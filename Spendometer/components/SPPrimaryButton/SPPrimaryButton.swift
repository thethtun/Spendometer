//
//  SPPrimaryButton.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

@IBDesignable
class SPPrimaryButton: BaseViewPod {
    
    @IBInspectable var buttonText : String = "Save"
    @IBInspectable var buttonImage : UIImage = #imageLiteral(resourceName: "ic_floppy_disk_accent") {
        didSet {
            imageViewIcon.image = buttonImage
        }
    }
    
    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var labelText : UILabel!
    @IBOutlet weak var imageViewIcon : UIImageView!
    
    var onClick : (()->Void)?
    
    override func commonInit() {
        loadNib(with: SPPrimaryButton.self).instantiate(withOwner: self, options: nil)
        setUpViewPod(with: containerView)
        
        setup()
    }
    
    func setup() {
        labelText.font = UIFont(name: SPFont.Futura.Bold, size: 18)
        labelText.textColor = SPColor.Basic.primaryColor
        labelText.text = buttonText
        
        imageViewIcon.image = buttonImage
        imageViewIcon.tintColor = SPColor.Basic.accentColor
        
        layer.cornerRadius = 18
        layer.masksToBounds = true
        
        let tap = UIGestureRecognizer(target: self, action: #selector(onClickButton(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc func onClickButton(_ sender : Any) {
        onClick?()
    }
}
