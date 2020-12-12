//
//  UpdateSpendingViewController.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class UpdateSpendingViewController: UIViewController {

    @IBOutlet weak var textFieldAmount : SPTextField!
    @IBOutlet weak var textFieldNote : SPTextField!
    @IBOutlet weak var buttonSelectCategory : SPSelectionButton!
    @IBOutlet weak var buttonSelectDateTime : SPSelectionButton!
    @IBOutlet weak var buttonSave : SPPrimaryButton!
    @IBOutlet weak var buttonDismiss : SPButtonSquare!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addActionListeners()
    }
    
    private func setupView() {
        textFieldAmount.placeholderText = "Enter amount"
        
        textFieldNote.placeholderText = "Add notes (optional)"
        
        buttonSelectCategory.image = #imageLiteral(resourceName: "ic_web_dev")
        buttonSelectCategory.text = "Select Category (Optional)"
        
        buttonSelectDateTime.image = #imageLiteral(resourceName: "ic_calendar")
        buttonSelectDateTime.text = "Select Time (Optional)"
        
        buttonSave.buttonText = "Save"
        
        buttonDismiss.image = #imageLiteral(resourceName: "ic_close_accent")
        buttonDismiss.containerView.backgroundColor = UIColor.white
    }

    fileprivate func addActionListeners() {
        buttonSave.onClick = {
            
        }
        
        buttonSelectCategory.onClick = {
            
        }
        
        buttonSelectDateTime.onClick = {
            
        }
        
        buttonDismiss.onClick = {
            self.dismiss(animated: true, completion: nil)
        }
    }


}
