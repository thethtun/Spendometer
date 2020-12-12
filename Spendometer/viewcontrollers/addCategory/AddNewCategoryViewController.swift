//
//  AddNewCategoryViewController.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class AddNewCategoryViewController: UIViewController {

    @IBOutlet weak var labelHeader : SPHeader!
    @IBOutlet weak var buttonSave : SPPrimaryButton!
    @IBOutlet weak var buttonDismiss : SPButtonSquare!
    @IBOutlet weak var textFieldCategoryName : SPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupActionListeners()
    }

    private func setupView() {
        labelHeader.text = "Add New Category"
        
        buttonSave.buttonText = "Save"
        buttonSave.buttonImage = #imageLiteral(resourceName: "ic_floppy_disk_accent")
        
        buttonDismiss.containerView.backgroundColor = UIColor.white
        buttonDismiss.image = #imageLiteral(resourceName: "ic_close_accent")
        
        textFieldCategoryName.placeholderText = "Enter Category Name"
    }
    
    private func setupActionListeners() {
        buttonDismiss.onClick = {
            self.dismiss(animated: true, completion: nil)
        }
    }

    
}
