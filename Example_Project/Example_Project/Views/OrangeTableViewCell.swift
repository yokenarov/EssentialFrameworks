//
//  OrangeTableViewCell.swift
//  Example_Project
//
//  Created by Jordan Kenarov on 30.10.21.
//

import UIKit
import GenericViews
class OrangeTableViewCell: UITableViewCell, GenericCell {
    var heightOfCell: CGFloat = 70.0
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .black
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
