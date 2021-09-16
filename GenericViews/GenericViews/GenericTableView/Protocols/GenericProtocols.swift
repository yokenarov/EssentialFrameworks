//
//  GenericProtocols.swift
//  GenericViews
//
//  Created by Jordan Kenarov on 12.09.21.
//

import Foundation
import UIKit
// Delegates
public protocol LoadMoreFromBottomDelegate: AnyObject {
    func loadMoreFromBottom(scrollView: UIScrollView)
}
///Any type that will be used as a filter value must inherit from this protocol.
public protocol Filterable {}
///A generic interface for a tableview with an array of items with predefined type and an array of cellTypes in which all the tableview cells that you plan to use must be declared. You can use the ready ones in the CellType enum, or if you need to implement your own cell, you have to add it to the CellType enum.
internal protocol GenericTableViewInterface: GenericFilterableInterface {
    associatedtype Model
    var items: [Model] { get set } 
}

///Provides a Generic protocol interface with which this table view can work. It contains a table view cell in which the instance of the model will be contained, a primaryValue to filter by and a secondary value to filter by.
public protocol GenericModelType: Identifiable, AnyObject { 
    var cellRepresentingModelType: GenericCell { get set }
    var primaryValueToFilterBy: Filterable { get set }
    var secondaryValueToFilterBy: Filterable { get set }
}

///Provides an identificator for individual instances inside the items and filtered items array by which the table view can filter.
public protocol Identifiable {
    var identificator: String { get set }
    var tableViewIdentificator: Identificator { get set }
}

///Provides an array of items that have been selected.
  protocol SelectableTableViewRows: UITableView {
    var selectedItems: [Identificator] { get set }
}
///Provides a filtration mechanism for when a tableview needs to be filtered and reloaded. There is also a default implementation with ready functions declared in an extension of this protocol.
internal protocol GenericFilterableInterface {
    associatedtype FilterableModel
    var isAllSelected: Bool { get set }
    var isSecondaryFilterAppliedToAll: Bool { get set }
    var filteredItems: [FilterableModel] { get set }
    
}
///Indicates wether a cell can be selectable or not.  This protocol requires that you implement the neccessary properties and methods so that you can display a state of a cell when its selected and when it is not. Any cell that is used in this tableView and has a selectable functionality, must inherit from this protocol.
public protocol SelectableCell: UITableViewCell {
    var isTapped: Bool { get set }
    var shouldUserInteractionBeEnabled: Bool { get set }
    var shouldShowSelection: Bool { get set }
    var container: UIView! { get set }
    var imageContainer: UIImageView! { get set }
    var imageForSelection: UIImage { get set }
    var widthConstraintOfContainer: NSLayoutConstraint! { get set }
    var identifier: Identificator { get set }
    func configureForSelection(selectedItems: [Identificator], identificator: Identificator, shouldShowSelection: Bool)
}

public protocol GenericCell: UITableViewCell {
    var heightOfCell: CGFloat { get set }
}
