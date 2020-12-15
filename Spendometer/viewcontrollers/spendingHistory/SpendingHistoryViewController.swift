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
    
    private let leadingInset : CGFloat = 20
    private let trailingInset : CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
        
        buttonDismiss.onClick = { _ in 
            self.dismiss(animated: true, completion: nil)
        }
    }

    private func setupView() {
        buttonDismiss.containerView.backgroundColor = UIColor.white
        buttonDismiss.image = #imageLiteral(resourceName: "ic_back")
        
        setupCollectionView()
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
    
}

extension SpendingHistoryViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpendingHistoryItemCell.self), for: indexPath) as? SpendingHistoryItemCell else { return UICollectionViewCell() }
        
        return cell
        
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

