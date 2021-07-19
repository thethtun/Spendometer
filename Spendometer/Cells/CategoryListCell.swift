//
//  CategoryListCell.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class CategoryListCell: UICollectionViewCell {

    @IBOutlet weak var labelText : UILabel!
    
    var data : SpendingCategory? {
        didSet {
            if let data = data {
                labelText.text = data.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        labelText.font = UIFont(name: SPFont.Futura.Bold, size: 24)
        labelText.textColor = SPColor.Text.primaryInfo
    }

}
