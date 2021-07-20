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
    
    var presenter : UpdateSpendingRecordPresenter?
    
    var recordID : String = ""
    var onDataUpdated : (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addActionListeners()
        setupPresenter()
    }
    
    private func setupPresenter() {
        presenter = UpdateSpendingRecordPresenterImpl()
        presenter?.mView = self
        
        presenter?.getSpendingRecordByID(id: recordID)
    }
    
    private func setupView() {
        textFieldAmount.textFieldInput.keyboardType = .numberPad
        textFieldAmount.placeholderText = "Enter amount"
        
        textFieldNote.placeholderText = "Add notes (optional)"
        
        buttonSelectCategory.image = #imageLiteral(resourceName: "ic_web_dev")
        buttonSelectCategory.text = "Select Category (Optional)"
        
        buttonSelectDateTime.image = #imageLiteral(resourceName: "ic_calendar")
        buttonSelectDateTime.text = "Select Time (Optional)"
        
        buttonSave.buttonText = "Update"
        
        buttonDismiss.image = #imageLiteral(resourceName: "ic_close_accent")
        buttonDismiss.containerView.backgroundColor = UIColor.white
        
        
    }

    fileprivate func addActionListeners() {
        buttonSave.onClick = {
            guard let spentAmount = self.textFieldAmount.textFieldInput.text, !spentAmount.isEmpty else {
                self.showAlert(message: "Enter Amount")
                return
            }
            
            var extraNotes = self.textFieldNote.textFieldInput.text ?? ""
            extraNotes = extraNotes.isEmpty ? "unknown" : extraNotes
            self.presenter?.updateRecord(amount: Double(spentAmount) ?? 0, notes: extraNotes)
        }
        
        buttonSelectCategory.onClick = {
            let vc = CategoryListViewController()
            vc.onCategorySelected = { data in
                self.buttonSelectCategory.text = data.name
                self.presenter?.onCategorySelected(data: data)
            }
            self.present(vc, animated: true, completion: nil)
        }
        
        buttonSelectDateTime.onClick = {
            
            let wrapperView = UIView()
            wrapperView.frame = CGRect(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY - 50, width: self.view.frame.width, height: 60)
            wrapperView.backgroundColor = .white
            
            // Create a DatePicker
            let datePicker: UIDatePicker = UIDatePicker()
            
            // Posiiton date picket within a view
//            datePicker.frame = CGRect(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY - 50, width: self.view.frame.width, height: 60)
            
            // Set some of UIDatePicker properties
            datePicker.timeZone = NSTimeZone.local
            datePicker.backgroundColor = UIColor.white
            
            // Add an event to call onDidChangeDate function when value is changed.
            datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
            
            // Add DataPicker to the view
//            self.view.addSubview(datePicker)
            wrapperView.addSubview(datePicker)
            datePicker.frame = CGRect(x: 10, y: 2, width: wrapperView.frame.width - 80, height: 55)

            
            self.view.addSubview(wrapperView)
            
            let closeButton = SPButtonSquare()
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.image = #imageLiteral(resourceName: "ic_checkmark")
            wrapperView.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor, constant: 0),
                closeButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -5),
                closeButton.widthAnchor.constraint(equalToConstant: 50),
                closeButton.heightAnchor.constraint(equalToConstant: 50),
            ])
            closeButton.onClick = { sender in
                UIView.animate(withDuration: 10) {
                    self.presenter?.dateTimeSelected(date: datePicker.date)
                    
                    //TODO: Fix
                    sender.superview?.superview?.superview?.superview?.removeFromSuperview()
                }
            }
        }
        

        
        buttonDismiss.onClick = { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        presenter?.dateTimeSelected(date: sender.date)
    }


}

extension UpdateSpendingViewController : UpdateSpendingRecordView {
    func onDataNotFound(data: String) {
        showAlert(message: data) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func onSpendingRecordLoaded(data: SpendingRecord) {
        textFieldAmount.textFieldInput.text = "\(Int(data.amount))"
        textFieldNote.textFieldInput.text = data.notes
        buttonSelectCategory.text = data.category.name
        buttonSelectDateTime.text = DateTimeUtils.convertToString(date: data.dateTime)
    }
    
    
    func updateSelectedDateTime(data: String) {
        buttonSelectDateTime.text = data
    }
    
    func onError(error: String) {
        showAlert(message: error)
    }
    
    func onSaveSuccess() {
        
        textFieldAmount.textFieldInput.text = ""
        textFieldNote.textFieldInput.text = ""

        onDataUpdated?()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
