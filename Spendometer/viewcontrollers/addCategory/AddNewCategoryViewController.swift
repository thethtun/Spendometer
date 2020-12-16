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
    
    var presenter : AddCategoryPresenter?
    var onNewCategorySaved : ((SpendingCategory)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        setupActionListeners()
        setPresenter()
    }

    private func setPresenter() {
        presenter = AddCategoryPresenterImpl()
        presenter?.mView = self
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
        buttonDismiss.onClick = { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        buttonSave.onClick = {
            guard let categoryName = self.textFieldCategoryName.textFieldInput.text, !categoryName.isEmpty else {
                self.showAlert(message: "Enter Category Name")
                return
            }
            
            self.presenter?.addNewCategory(data: categoryName)
        }
    }

    
}

extension AddNewCategoryViewController : AddCategoryView {
    
    func onNewCategorySaved(data: SpendingCategory) {
        onNewCategorySaved?(data)
        self.dismiss(animated: true, completion: nil)
    }
    
    func onError(error: String) {
        showAlert(message: error)
    }
    
    
}
