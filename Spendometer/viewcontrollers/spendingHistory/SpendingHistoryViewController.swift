//
//  SpendingHistoryViewController.swift
//  Spendometer
//
//  Created by Thet Htun on 12/12/20.
//

import UIKit

class SpendingHistoryViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var labelAmount : UILabel!
    @IBOutlet weak var buttonSelectDate : SPSelectionButton!
    @IBOutlet weak var buttonDismiss : SPButtonSquare!
    @IBOutlet weak var labelEmptyListView : UILabel!
    
    private let leadingInset : CGFloat = 20
    private let trailingInset : CGFloat = 20
    private let datePicker : UIDatePicker = UIDatePicker()
    private var latestFilterDate : Date = Date()
    
    var presenter : SpendingHistoryPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupActionListener()
        setupPresenter()
    }
    
    private func setupActionListener() {
        buttonDismiss.onClick = { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        buttonSelectDate.onClick = {
            let wrapperView = UIView()
            wrapperView.frame = CGRect(x: 0, y: self.view.safeAreaLayoutGuide.layoutFrame.maxY - 50, width: self.view.frame.width, height: 60)
            wrapperView.backgroundColor = .white
            
            // Create a DatePicker
            let datePicker: UIDatePicker = UIDatePicker()
            
            // Set some of UIDatePicker properties
            datePicker.timeZone = NSTimeZone.local
            datePicker.datePickerMode = .date
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
            closeButton.image = #imageLiteral(resourceName: "ic_close_accent")
            wrapperView.addSubview(closeButton)
            NSLayoutConstraint.activate([
                closeButton.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor, constant: 0),
                closeButton.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -5),
                closeButton.widthAnchor.constraint(equalToConstant: 50),
                closeButton.heightAnchor.constraint(equalToConstant: 50),
            ])
            closeButton.onClick = { sender in
                UIView.animate(withDuration: 10) {
                    //TODO: Fix
                    sender.superview?.superview?.superview?.superview?.removeFromSuperview()
                }
            }
        }
    }
    
    private func setupPresenter() {
        presenter = SpendingHistoryPresenterImpl()
        presenter?.mView = self
        
        presenter?.getSpendingListByDate(date: latestFilterDate)
    }
    
    private func setupView() {
        buttonDismiss.containerView.backgroundColor = UIColor.white
        buttonDismiss.image = #imageLiteral(resourceName: "ic_back")
        
        setupCollectionView()
        
        buttonSelectDate.text = DateTimeUtils.convertToString(date: Date(), format: "dd/MM/yyyy")

    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical  // .horizontal
        }
        
        collectionView.register(UINib(nibName: String(describing: SpendingHistoryItemCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: SpendingHistoryItemCell.self))
    }
  
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        buttonSelectDate.text = formatter.string(from: sender.date)
        latestFilterDate = sender.date
        self.presenter?.getSpendingListByDate(date: latestFilterDate)
        self.view.endEditing(true)
    }
}

extension SpendingHistoryViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemCount = presenter?.spendingHistory.count ?? 0
        labelEmptyListView.isHidden = !(itemCount == 0)
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpendingHistoryItemCell.self), for: indexPath) as? SpendingHistoryItemCell else { return UICollectionViewCell() }
        
        cell.data = presenter?.spendingHistory[indexPath.row]
        cell.onClickDelete = { data in
            self.presenter?.deleteHistoryItemBydID(id: data.id)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UpdateSpendingViewController()
        vc.recordID = self.presenter?.spendingHistory[indexPath.row].id ?? ""
        vc.onDataUpdated = {
            self.presenter?.getSpendingListByDate(date: self.latestFilterDate)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

extension SpendingHistoryViewController:UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - (leadingInset + trailingInset)
        return CGSize(width: width, height:  100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}

extension SpendingHistoryViewController : SpendingHistoryView {
    
    func onTotalSpendingCalculated(totalSpending: String) {
        labelAmount.text = "\(totalSpending) KS"
    }
    
    
    func onSpendingHistoryReady(data: [SpendingRecord]) {
        collectionView.reloadData()
    }
    
    func onError(error: String) {
        
        showAlert(message: error)
    }
    
}
