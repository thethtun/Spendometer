//
//  SPSelectionButton.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class SPSelectionButton: BaseViewPod {

    @IBOutlet weak var labelText : UILabel!
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    
    var image : UIImage = #imageLiteral(resourceName: "ic_timer") {
        didSet {
            imageView.image = image
        }
    }
    
    var text : String = "Something here" {
        didSet {
            labelText.text = text
        }
    }
    var onClick : (()->Void)?
    
    override func commonInit() {
        loadNib(with: SPSelectionButton.self).instantiate(withOwner: self, options: nil)
        setUpViewPod(with: containerView)
        
        setup()
    }
    
    func setup() {
        labelText.font = UIFont(name: SPFont.Futura.Bold, size: 14)
        labelText.textColor = SPColor.Text.primaryInfo
        labelText.text = text
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        imageView.image = image
        imageView.tintColor = UIColor.white
        
        
    }
    
    @IBAction func onClick(_ sender : Any) {
        onClick?()
    }
}


