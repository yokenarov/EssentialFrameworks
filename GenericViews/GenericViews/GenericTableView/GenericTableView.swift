//
//  GenericTableView.swift
//  MyMtel
//
//  Created by Jordan Kenarov on 19.05.21.
//  Copyright © 2021 Alexandra T. Georgieva. All rights reserved.
//

import Foundation
import Combine
import UIKit

#if canImport(Essentials)
import Essentials
#endif
#if canImport(NetworkingAPI)
import NetworkingAPI
#endif
/**
 This is a reusable tableview with a number of functionalities that can work with any type that conforms to the GenericModelType.
 */
/// List of functionalities:
/// - Selectable Cells - With this functionality you can select any cell and perform actions on it. The table view will configure the cell's state internally, depending on the implementation you provide in SelectableCell.configureForSelection function. Currently the only action that can be done with the selected state is deletion. In the future, further functionalities like expanding cells can be added.
/// - Filtration - With this functionality you can filter the table view items array by either a primary filter value or by a secondary filter value. Two functions with a default implementation are provided for you within an extension of this class.
@available(iOS 13.0.0, *)
public class GenericTableView: UITableView, UITableViewDataSource, UITableViewDelegate, GenericTableViewInterface, SelectableTableViewRows {
    public typealias Model = GenericSectionWithItems
    public typealias FilterableModel = GenericSectionWithItems
    
    //MARK: - Variables
    public var items: [Model]
    internal var filteredItems: [FilterableModel]
    internal var selectedItems: [Identificator]
    internal var filtratedSelecteditems: [String]    = []
    internal var isAllSelected: Bool
    internal var isSecondaryFilterAppliedToAll: Bool = false
    private  var tableViewHasSections: Bool
    private  var shouldShowSelection                 = false
    private  var allCellClasses: [GenericCell.Type]  = []
    private  weak var loadMoreDelegate: LoadMoreFromBottomDelegate?
    
    //MARK: - Publishers
    public var cellForRowAt   = PassthroughSubject<(GenericModelType, GenericCell), Never>()
    public var didSelectRowAt = PassthroughSubject<GenericModelType, Never>()
    
    //MARK: - Initializer 
    public init (frame:CGRect, items:[Model],tableViewStyle: UITableView.Style, loadmoreDelegate: LoadMoreFromBottomDelegate, isAllSelected: Bool) {
        self.items                                     = items
        self.loadMoreDelegate                          = loadmoreDelegate
        self.selectedItems                             = []
        self.filteredItems                             = self.items
        self.tableViewHasSections                      = self.items.count > 1 ? true : false
        self.isAllSelected                             = isAllSelected
        super.init(frame: frame, style: tableViewStyle)
        #if canImport(Essentials)
        self.allCellClasses                            = allClasses { $0.compactMap { $0 as? GenericCell.Type } }
        #endif
        self.delegate                                  = self
        self.dataSource                                = self
        self.estimatedRowHeight                        = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rowHeight = UITableView.automaticDimension
        for item in allCellClasses {
            self.register(item, forCellReuseIdentifier: "\(item)")
            self.register(UINib(nibName: "\(item)", bundle: nil), forCellReuseIdentifier: "\(item)")
        }
        if #available(iOS 15.0, *) {
        self.sectionHeaderTopPadding = 0
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableView Delegate&DataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        tableViewHasSections ? items.count : 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getCorrectArray(section: section).count
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableViewHasSections && !items[section].sectionText.isEmpty ? items[section].sectionLabel : nil
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableViewHasSections && !items[section].sectionText.isEmpty ? items[section].sectionHeight : 0
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    } 
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = getCorrectArray(section: indexPath.section)[indexPath.row]
        return item.cellRepresentingModelType.getHeight()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellRepresentingModelType = getCorrectArray(section: indexPath.section)[indexPath.row].cellRepresentingModelType
        
        let c = cellRepresentingModelType
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: c.cellReuseIdentifier(), for: indexPath) as? GenericCell else { return UITableViewCell()}
        var item = getCorrectArray(section: indexPath.section)[indexPath.row]
        
        cellForRowAt.send((item, cell))
        if let cell = cell as? SelectableCell {
            item.identificator = "\(indexPath.row)"
            
            item.tableViewIdentificator = Identificator(identificatior: item.identificator, indexPath: indexPath.row)
            cell.configureForSelection(selectedItems: self.selectedItems, identificator: Identificator(identificatior: item.identificator, indexPath: indexPath.row), shouldShowSelection: shouldShowSelection)
            cell.isUserInteractionEnabled = true
        }
        return  cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = getCorrectArray(section: indexPath.section)[indexPath.row]
        updateSelectedItemsWithNew(identifier: item.tableViewIdentificator)
        
        didSelectRowAt.send(item)
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == self.getCorrectArray(section: indexPath.section).count {
            loadMoreDelegate?.loadMoreFromBottom(scrollView: UIScrollView())
            return
        }
    }
    //MARK: - Helper Functions
//    public func refreshIdentificatorWhenNewItemIsInsertedAtTopOfOriginalArray() {
//        for i in 1...items.count - 1 {
//            items[i].identificator = "\(i)"
//        }
//    }
    
//    public func reloadWithSelectedAll() {
//        if isAllSelected && !isSecondaryFilterAppliedToAll {
//            for row in 0...items.count - 1 {
//                self.selectedItems.append(Identificator(identificatior: items[row].identificator, indexPath: row))
//            }
//            self.reloadData()
//        }else {
//            for row in 0...filteredItems.count - 1 {
//                self.selectedItems.append(Identificator(identificatior: filteredItems[row].identificator, indexPath: row))
//            }
//            self.reloadData()
//        }
//    }
    
    public func reloadWithDeselectAll() {
        self.selectedItems.removeAll()
        self.reloadData()
    }
    
    func getCorrectArray(section: Int) -> [GenericModelType] {
        if isAllSelected {
            if isSecondaryFilterAppliedToAll {
                return filteredItems[section].items
            }else {
                return items[section].items
            }
        }else {
            return filteredItems[section].items
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
                reloadData()
    }
}

 


