//
//  TableViewCell.swift
//  Socket
//
//  Created by Bodour Alrashidi on 21/12/2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameCelLabel: UILabel!
    
    @IBOutlet weak var ProfileCellImage: UIImageView!
    @IBOutlet weak var phoneCellLabel: UILabel!
    override func awakeFromNib() {
        ProfileCellImage.layer.borderWidth = 1
        ProfileCellImage.layer.masksToBounds = false
        ProfileCellImage.layer.borderColor = UIColor.black.cgColor
        ProfileCellImage.layer.cornerRadius = ProfileCellImage.frame.height/2
        ProfileCellImage.clipsToBounds = true
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
