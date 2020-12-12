//
//  SpendingHistoryItemCell.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class SpendingHistoryItemCell: UICollectionViewCell {

    @IBOutlet weak var labelSpendingContent : UILabel!
    @IBOutlet weak var labelAmount : UILabel!
    @IBOutlet weak var labelTime : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var mainWrapper : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        mainWrapper.layer.borderWidth = 0.5
        mainWrapper.layer.borderColor = UIColor.white.cgColor
        
        mainWrapper.layer.cornerRadius = 20
        mainWrapper.layer.masksToBounds = true
    }

    
}
