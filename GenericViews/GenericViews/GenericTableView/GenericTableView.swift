//
//  GenericTableView.swift
//  MyMtel
//
//  Created by Jordan Kenarov on 19.05.21.
//  Copyright © 2021 Alexandra T. Georgieva. All rights reserved.
//

import Foundation
import UIKit

#if canImport(Essentials)
import Essentials
#endif
/**
 This is a reusable tableview with a number of functionalities that can work with any type that conforms to the GenericModelType.
 */
/// List of functionalities:
/// - Selectable Cells - With this functionality you can select any cell and perform actions on it. The table view will configure the cell's state internally, depending on the implementation you provide in SelectableCell.configureForSelection function. Currently the only action that can be done with the selected state is deletion. In the future, further functionalities like expanding cells can be added.
/// - Filtration - With this functionality you can filter the table view items array by either a primary filter value or by a secondary filter value. Two functions with a default implementation are provided for you within an extension of this class.
@available(iOS 13.0.0, *)
public class GenericTableView: UITableView, UITableViewDataSource, UITableViewDelegate, GenericTableViewInterface, SelectableTableViewRows {
    public typealias Model = GenericModelType
    public typealias FilterableModel = GenericModelType
    //MARK: - Variables
    public var items: [Model]
    internal var filteredItems: [FilterableModel]
    internal var selectedItems: [Identificator]
    internal var filtratedSelecteditems: [String]    = []
    internal var isAllSelected: Bool
    internal var isSecondaryFilterAppliedToAll: Bool = false
    private  var shouldShowSelection                 = false
    private  var allCellClasses: [GenericCell.Type]  = []
    private  weak var loadMoreDelegate: LoadMoreFromBottomDelegate?
    
    //MARK: - Closures
    var cellForRowAt: ((Model, GenericCell) -> ())?
    var didSelectRowAt: ((Model) -> ())?
    
    //MARK: - Initializer 
    public init (frame:CGRect, items:[Model],tableViewStyle: UITableView.Style, loadmoreDelegate: LoadMoreFromBottomDelegate, isAllSelected: Bool, cellForRowAt: @escaping (Model, GenericCell) -> (), didSelectRowAt: @escaping (Model) -> ()) {
        self.items                                     = items
        self.loadMoreDelegate                          = loadmoreDelegate
        self.cellForRowAt                              = cellForRowAt
        self.didSelectRowAt                            = didSelectRowAt
        self.selectedItems                             = []
        self.filteredItems                             = self.items
        self.isAllSelected                             = isAllSelected
        super.init(frame: frame, style: tableViewStyle)
        #if canImport(Essentials)
        self.allCellClasses                            = allClasses { $0.compactMap { $0 as? GenericCell.Type } }
        #endif
        self.delegate                                  = self
        self.dataSource                                = self
        self.estimatedRowHeight                        = 130
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for item in allCellClasses {
            self.register(item, forCellReuseIdentifier: "\(item)")
            self.register(UINib(nibName: "\(item)", bundle: nil), forCellReuseIdentifier: "\(item)")
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableView Delegate&DataSource Methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCorrectArray().count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = getCorrectArray()[indexPath.row]
        return item.cellRepresentingModelType.getHeight()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRepresentingModelType = getCorrectArray()[indexPath.row].cellRepresentingModelType
        
        let c = cellRepresentingModelType
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: c.cellReuseIdentifier(), for: indexPath) as? GenericCell else { return UITableViewCell()}
        var item = getCorrectArray()[indexPath.row]
        
        cellForRowAt?(item, cell)
        
        if let cell = cell as? SelectableCell {
            item.identificator = "\(indexPath.row)"
            
            item.tableViewIdentificator = Identificator(identificatior: item.identificator, indexPath: indexPath.row)
            cell.configureForSelection(selectedItems: self.selectedItems, identificator: Identificator(identificatior: item.identificator, indexPath: indexPath.row), shouldShowSelection: shouldShowSelection)
            cell.isUserInteractionEnabled = true
        }else {
            cell.isUserInteractionEnabled = false
        }
        return  cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = getCorrectArray()[indexPath.row]
        updateSelectedItemsWithNew(identifier: item.tableViewIdentificator)
        didSelectRowAt?(item)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.getCorrectArray().count {
            loadMoreDelegate?.loadMoreFromBottom(scrollView: UIScrollView())
            return
        }
    }
    //MARK: - Helper Functions
    public func refreshIdentificatorWhenNewItemIsInsertedAtTopOfOriginalArray() {
        for i in 1...items.count - 1 {
            items[i].identificator = "\(i)"
        }
    }
    
    public func reloadWithSelectedAll() {
        if isAllSelected && !isSecondaryFilterAppliedToAll {
            for row in 0...items.count - 1 {
                self.selectedItems.append(Identificator(identificatior: items[row].identificator, indexPath: row))
            }
            self.reloadData()
        }else {
            for row in 0...filteredItems.count - 1 {
                self.selectedItems.append(Identificator(identificatior: filteredItems[row].identificator, indexPath: row))
            }
            self.reloadData()
        }
    }
    
    public func reloadWithDeselectAll() {
        self.selectedItems.removeAll()
        self.reloadData()
    }
    
    func getCorrectArray() -> [GenericModelType] {
        if isAllSelected {
            if isSecondaryFilterAppliedToAll {
                return filteredItems
            }else {
                return items
            }
        }else {
            return filteredItems
        }
    }
}
//MARK: - Extensions
extension SelectableTableViewRows {
    //MARK: UpdateSelectedItemsArray
    func updateSelectedItemsWithNew(identifier: Identificator) {
        if self.selectedItems.count != 0 {
            if selectedItems.contains(identifier) {
                self.selectedItems = self.selectedItems.filter({$0.identificator != identifier.identificator})
            }else {
                self.selectedItems.append(identifier)
            }
        } else {
            self.selectedItems.append(identifier)
        }
        //        reloadData()
    }
}

// MARK: - Helper Functions for Notifications
@available(iOS 13.0.0, *)
extension GenericTableView {
    //MARK: Reload Functions
    func reloadWithNewItemsOnTop<F>(newItems: [GenericModelType], secondaryFilter: F) where F: Filterable, F: Equatable{
        var trappedIndexPaths: [IndexPath] = []
        var trappedFilteredIndexes: [IndexPath] = []
        
        self.items.insert(newItems[0], at: 0)
        if isAllSelected && !isSecondaryFilterAppliedToAll {
            for i in 0...newItems.count - 1 {
                let indexPath = IndexPath(row: i, section: 0)
                trappedIndexPaths.append(indexPath)
            }
        }else {
            for i in 0...newItems.count - 1 {
                self.filteredItems.insert(newItems[i], at: 0)
                let indexPath = IndexPath(row: i, section: 0)
                trappedFilteredIndexes.append(indexPath)
            }
        }
        UIView.animate(withDuration: 0.5) {
            self.isAllSelected && !self.isSecondaryFilterAppliedToAll ? UIView.transition(with: self, duration: 0.5 , options: .curveEaseInOut, animations: {self.insertRows(at: trappedIndexPaths, with: .right)}, completion: nil) : UIView.transition(with: self, duration: 0.5 , options: .curveEaseInOut, animations: {self.insertRows(at: trappedFilteredIndexes, with: .right)}, completion: nil)
        }
    }
    
    public  func reloadDataWithDeletedItems() {
        if self.selectedItems.count != 0 {
            
            var trappedIndexPaths: [IndexPath] = []
            var trappedFilteredIndexes: [IndexPath] = []
            
            if isAllSelected && !isSecondaryFilterAppliedToAll {
                for item in selectedItems {
                    self.items = items.filter({$0.identificator != item.identificator})
                    let indexPath = IndexPath(row: item.indexPath, section: 0)
                    trappedIndexPaths.append(indexPath)
                }
            }else {
                for item in selectedItems {
                    self.items = items.filter({$0.identificator != item.identificator})
                    self.filteredItems = filteredItems.filter({$0.identificator != item.identificator})
                    let indexPath = IndexPath(row: item.indexPath, section: 0)
                    trappedFilteredIndexes.append(indexPath)
                }
            }
            
            self.selectedItems.removeAll()
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                
                guard let strongSelf = self else { return }
                UIView.transition(with: strongSelf, duration: 0.1 , options: .transitionCrossDissolve, animations: {self?.reloadData()}, completion: nil)
                self?.isUserInteractionEnabled = true
            }
            self.isAllSelected && !isSecondaryFilterAppliedToAll ? self.deleteRows(at: trappedIndexPaths, with: .left) : self.deleteRows(at: trappedFilteredIndexes, with: .left)
        }
    }
    
    func reloadFromBottom<F>(newItems: [GenericModelType], secondaryFilter: F, scrollView: UIScrollView) where F: Equatable, F: Filterable{
        
        var heightOfAllCells: CGFloat = 0
        guard newItems.count > 0 else { return }
        for i in 0...newItems.count - 1 {
            var item = newItems[i]
            if i != newItems.count - 1 {
                heightOfAllCells += item.cellRepresentingModelType.getHeight()
            }
            if i == 0 {
                item.identificator = "\(self.items.count)"
            }else {
                item.identificator = "\(self.items.count + i)"
            }
        }
        if isAllSelected && !isSecondaryFilterAppliedToAll {
            items.append(contentsOf: newItems)
        }else {
            items.append(contentsOf: newItems)
            filteredItems = self.items.filter({ item in
                secondaryFilter.isEqualTo(other: item.secondaryValueToFilterBy) ? item.secondaryValueToFilterBy as? F == secondaryFilter : false
            })
        }
        
        UIView.transition(with: self, duration: 0 , options: .curveEaseOut, animations: {self.reloadData()}, completion: nil)
        
    }
    
    //MARK : Primary Filter
    func primaryFilterBy<P>(providedValue: P) where P:Equatable,P:Filterable {
        self.filteredItems = self.items.filter({ item in
            providedValue.isEqualTo(other: item.primaryValueToFilterBy) ? item.primaryValueToFilterBy as? P == providedValue : false
        })
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
    
    //MARK : Secondary Filter
    func secondaryFilterBY<FilterValue>(providedValue: FilterValue, primaryFilter: FilterValue, secondaryFilter: FilterValue) where FilterValue: Equatable, FilterValue: Filterable {
        
        let originalItems = self.items
        
        if isAllSelected && isSecondaryFilterAppliedToAll {
            self.filteredItems = originalItems.filter({ item in
                providedValue.isEqualTo(other: item.secondaryValueToFilterBy) ? item.secondaryValueToFilterBy as? FilterValue == providedValue : false
            })
        }else if !isAllSelected && !isSecondaryFilterAppliedToAll {
            primaryFilterBy(providedValue: primaryFilter)
            
        }else if !isAllSelected && isSecondaryFilterAppliedToAll {
            primaryFilterBy(providedValue: primaryFilter)
            self.filteredItems = self.filteredItems.filter({ item in
                providedValue.isEqualTo(other: item.secondaryValueToFilterBy) ? item.secondaryValueToFilterBy as? FilterValue == providedValue : false
            })
        }
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {self.reloadData()}, completion: nil)
    }
}


