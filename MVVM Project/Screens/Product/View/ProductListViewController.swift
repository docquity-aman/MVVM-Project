//
//  ProductListViewController.swift
//  MVVM Project
//
//  Created by Aman Verma on 08/02/23.
//

import UIKit

class ProductListViewController: UIViewController {
    private var viewModel=ProductViewModel()
    @IBOutlet weak var productTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        // Do any additional setup after loading the view.
    }
    

}

extension ProductListViewController{
    func configuration(){
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }
    func initViewModel(){
        viewModel.fetchProducts()
        
    }
    //Data binding ->will observe the event
    func observeEvent(){
        viewModel.eventHandler={
            [weak self] event in
            guard let self else{return}
            switch event{
            case .loading:print("Loading..")
            case .stoploading:print("Stop Loading...")
            case .dataloading:
                print(self.viewModel.products)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case.error(let error):print(error as Any)
            }
        }
        
    }
}

extension ProductListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")as? ProductCell else{
            return UITableViewCell()
        }
        let product=viewModel.products[indexPath.row]
        cell.product=product
        return cell
    }
    

    
}
