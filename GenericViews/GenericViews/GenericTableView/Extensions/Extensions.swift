//
//  Extensions.swift
//  GenericViews
//
//  Created by Jordan Kenarov on 12.09.21.
//

import Foundation
import UIKit
//MARK: - Supporting Classes
///This struct contains the identificator of an individual item and the indexPath at which it can be found in the items or filteredItems array. It is used in the selection of a cell and when a cell needs to be deleted.
public struct Identificator: Equatable {
    public init (identificatior: String, indexPath: Int) {
        self.identificator = identificatior
        self.indexPath = indexPath
    }
   public var identificator: String
   public var indexPath: Int
}
 
// MARK: - Filterable Conformance
extension String: Filterable {}
extension Int: Filterable {}


// MARK: - Protocol extensions
extension Filterable  {
    func asString() -> String {
        return self as! String
    }
}
// MARK: - FILTERABLE
extension Filterable where Self: Equatable {
    func isEqualTo(other: Filterable) -> Bool {
        if let o = other as? Self { return self == o }
        return false
    }
}
// MARK - GENERIC TABLEVIEW CELL
@available(iOS 13.0.0, *)
extension GenericCell {
    func getInstanceOfType() -> GenericCell{
        return self
    }
    func getClass() ->  GenericCell.Type {
        return Self.self
    }
  
    func getHeight() -> CGFloat {
        return heightOfCell
    }
    
    func cellReuseIdentifier() -> String { "\(Self.self)" }
}

extension SelectableCell {
    func configureForSelection(selectedItems: [Identificator],identificator: Identificator, shouldShowSelection: Bool) { 
        identifier = identificator
        if self.shouldShowSelection {
            if  selectedItems.contains(identificator) {
                isTapped = true
            }else {
                isTapped = false
            }
        }
    }
} 
//NSOBJECT

