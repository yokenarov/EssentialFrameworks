//
//  SupportingClasses.swift
//  GenericViews
//
//  Created by Jordan Kenarov on 23.10.21.
//

import Foundation
import UIKit

public class GenericSectionWithItems {
   private var sectionText = ""
   public var sectionHeight: CGFloat = 40
   private var fontSize: CGFloat
   private var fontName: String
   public var items: [GenericModelType]
   public var sectionLabel: UILabel {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: sectionHeight)
        label.text = "   \(sectionText)"
        label.backgroundColor = UIColor.lightGray
        label.textAlignment = .left
        label.font = UIFont(name: fontName, size: fontSize)
        return label
    }
   public init(sectionLableBuilder: SectionLableBuilder, items: [GenericModelType]) {
        self.items = items
        self.sectionText = sectionLableBuilder.sectionText
        self.sectionHeight = sectionLableBuilder.sectionHeight
        self.fontSize = sectionLableBuilder.fontSize
        self.fontName = sectionLableBuilder.fontName
    }
}

public class SectionLableBuilder {
    var sectionText: String
    var fontName: String = ""
    var fontSize: CGFloat
    var sectionHeight: CGFloat
   public init(sectiontext: String, fontSize: CGFloat, sectionHeight: CGFloat,_ fontName: String?) {
        self.sectionText = sectiontext
        self.fontSize = fontSize
        self.sectionHeight = sectionHeight
        self.fontName = fontName ?? ""
    }
}
