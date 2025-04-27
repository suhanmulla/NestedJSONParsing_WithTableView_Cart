//
//  CartsTableViewCell.swift
//  NestedJSONParsing_WithTableView_Cart
//
//  Created by Macintosh on 15/04/25.
//

import UIKit
import Kingfisher

class CartsTableViewCell: UITableViewCell {

    @IBOutlet weak var cartIdLbl: UILabel!
    
    @IBOutlet weak var cartTotalLbl: UILabel!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var cartTotalProductsLbl: UILabel!
    
    @IBOutlet weak var cartTotalQuantityLbl: UILabel!
    
    var cart1 : [Carts] = []
    
    var product1 : [Products] = [] {
        didSet {
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeViews()
        registerCellWithTableView()
    }
    
    func initializeViews() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
    }
    
    func registerCellWithTableView() {
        let uiNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        self.productCollectionView.register(uiNib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension CartsTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (productCollectionView.frame.width - 20) / 3, height: (productCollectionView.frame.height))
    }
}

extension CartsTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let prCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        if let imgUrl = URL(string: product1[indexPath.row].thumbnail) {
            prCell.thumbnailImgView.kf.setImage(with: imgUrl)
        }
        
        return prCell
    }
}
