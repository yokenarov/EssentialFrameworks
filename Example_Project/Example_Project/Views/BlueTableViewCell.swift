//
//  BlueTableViewCell.swift
//  BladiBla
//
//  Created by Jordan Kenarov on 23.10.21.
//

import UIKit
import GenericViews
class BlueTableViewCell: UITableViewCell, GenericCell {
    var heightOfCell: CGFloat = 50.0
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = .white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
