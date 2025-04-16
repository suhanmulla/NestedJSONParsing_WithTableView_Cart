//
//  ViewController.swift
//  NestedJSONParsing_WithTableView_Cart
//
//  Created by Macintosh on 15/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var cart1 : [Carts] = []
    var product1 : [Products] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViews()
        registerCellWithTableView()
        initSettings()
        jsonSerialization()
    }
    
    func initializeViews() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    
    func registerCellWithTableView() {
        let uiNib = UINib(nibName: "CartsTableViewCell", bundle: nil)
        self.cartTableView.register(uiNib, forCellReuseIdentifier: "CartsTableViewCell")
    }

    func initSettings() {
        url = URL(string: Constants.urlString)
        urlRequest = URLRequest(url: url!)
        urlSession = URLSession(configuration: .default)
    }
    
    func jsonSerialization() {
        let dataTask = urlSession?.dataTask(with: urlRequest!, completionHandler: {
            serviceData, serviceRes, error in
            
            let apiResponse = try! JSONSerialization.jsonObject(with: serviceData!) as! [String:Any]
            
            let extractedCarts = apiResponse ["carts"] as! [[String:Any]]
            let total = apiResponse ["total"] as! Int
            let skip = apiResponse ["skip"] as! Int
            let limit = apiResponse ["limit"] as! Int
                        
            for eachCarts in extractedCarts {
                let id = eachCarts ["id"] as! Int
                let extractedProducts = eachCarts ["products"] as! [[String:Any]]
                let total = eachCarts ["total"] as! Double
                let discountedTotal = eachCarts ["discountedTotal"] as! Double
                let userId = eachCarts ["userId"] as! Int
                let totalProducts = eachCarts ["totalProducts"] as! Int
                let totalQuantity = eachCarts ["totalQuantity"] as! Int
                
                for eachProducts in extractedProducts {
                    let id = eachProducts ["id"] as! Int
                    let title = eachProducts ["title"] as! String
                    let price = eachProducts ["price"] as! Double
                    let quantity = eachProducts ["quantity"] as! Int
                    let total = eachProducts ["total"] as! Double
                    let discountPercentage = eachProducts ["discountPercentage"] as! Double
                    let discountedTotal = eachProducts ["discountedTotal"] as! Double
                    let thumbnail = eachProducts ["thumbnail"] as! String
                    
                    let product0 = Products(id: id, title: title, price: price, quantity: quantity, total: total, discountPercentage: discountPercentage, discountedTotal: discountedTotal, thumbnail: thumbnail)
                    
                    self.product1.append(product0)
                    
                    print(self.product1)
                }
                
                let carts0 = Carts(id: id, products: self.product1, total: total, discountedTotal: discountedTotal, userId: userId, totalProducts: totalProducts, totalQuantity: totalQuantity)
                
                self.cart1.append(carts0)
                
                print(self.cart1)
                
            }
            
            DispatchQueue.main.sync {
                self.cartTableView.reloadData()
            }
            
        })
        
        dataTask?.resume()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.cartTableView.dequeueReusableCell(withIdentifier: "CartsTableViewCell") as! CartsTableViewCell
        
        cell.cartIdLbl.text = "\(cart1[indexPath.row].id)"
        cell.cartTotalLbl.text = "\(cart1[indexPath.row].total)"
        cell.product1 = cart1[indexPath.row].products             // Collection view on table View
        cell.cartTotalProductsLbl.text = "\(cart1[indexPath.row].totalProducts)"
        cell.cartTotalQuantityLbl.text = "\(cart1[indexPath.row].totalQuantity)"
        
        return cell
    }
}
