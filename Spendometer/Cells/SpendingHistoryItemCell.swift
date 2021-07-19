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
    
    var onClickDelete : ((SpendingRecord)->Void)?
    
    var data : SpendingRecord? {
        didSet {
            if let data = data {
                labelTime.text = DateTimeUtils.convertToString(date: data.dateTime)
                labelAmount.text = "\((Double(String(format: "%.0f", data.amount)) ?? 0).withCommas()) KS"
                labelSpendingContent.text = data.notes
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        mainWrapper.layer.borderWidth = 0.5
        mainWrapper.layer.borderColor = UIColor.white.cgColor
        
        mainWrapper.layer.cornerRadius = 20
        mainWrapper.layer.masksToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickToDelete))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
       
    }

    
    @objc func clickToDelete(tapGestureRecognizer: UITapGestureRecognizer) {
        // Your action
        if let data = data {
            onClickDelete?(data)
        }
    }
}
