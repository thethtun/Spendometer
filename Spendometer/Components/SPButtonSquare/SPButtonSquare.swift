//
//  SPButtonSquare.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class SPButtonSquare: BaseViewPod {

    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    
    var image : UIImage = #imageLiteral(resourceName: "ic_calendar") {
        didSet {
            imageView.image = image
        }
    }
    
    var onClick : ((_ sender : UIButton)->Void)?
    
    override func commonInit() {
        loadNib(with: SPButtonSquare.self).instantiate(withOwner: self, options: nil)
        setUpViewPod(with: containerView)
        
        setup()
    }
    
    func setup() {
        imageView.image = image
        
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
    
    @IBAction func onClickAction(_ sender : UIButton) {
        onClick?(sender)
    }
    
}


