//
//  SPTextField.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit


@IBDesignable
class SPTextField: BaseViewPod, UITextFieldDelegate {

    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var textFieldInput : UITextField!
    
    var placeholderText : String = "Placeholder Text" {
        didSet {
            textFieldInput.placeholder = placeholderText
        }
    }
    
    override func commonInit() {
        loadNib(with: SPTextField.self).instantiate(withOwner: self, options: nil)
        setUpViewPod(with: containerView)
        
        setup()
    }
    
    func setup() {
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        textFieldInput.borderStyle = .none
        textFieldInput.font = UIFont(name: SPFont.Futura.Medium, size: 18)
//        textFieldInput.textColor = SPColor.Text.primaryInfo
        
        textFieldInput.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                                  attributes: [
                                                                    NSAttributedString.Key.foregroundColor: SPColor.Text.hint ?? UIColor.gray,
                                                                    NSAttributedString.Key.font: UIFont(name: SPFont.Futura.Medium, size: 18) ?? UIFont.systemFont(ofSize: 18),
                                                                  ])
    }
    
   
}


