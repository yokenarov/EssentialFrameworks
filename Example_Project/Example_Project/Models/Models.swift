//
//  Models.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 23.10.21.
//

import Foundation
import GenericViews

class Blue : GenericModelType {
    var title = ""
    var cellRepresentingModelType: GenericCell = BlueTableViewCell()
    
    var primaryValueToFilterBy: Filterable = ""
    
    var secondaryValueToFilterBy: Filterable = ""
    
    var identificator: String = ""
    
    var tableViewIdentificator: Identificator = Identificator(identificatior: "", indexPath: 0)
    
}
