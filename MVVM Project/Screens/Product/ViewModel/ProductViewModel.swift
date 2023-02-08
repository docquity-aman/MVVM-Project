//
//  ProductViewModel.swift
//  MVVM Project
//
//  Created by Aman Verma on 08/02/23.
//

import Foundation

final class ProductViewModel{
    var products:[Product]=[]
    
    var eventHandler:((_ event:Event)-> Void)?
    
    func fetchProducts(){
        self.eventHandler?(.loading)
        APIManger.shared.fetchroducts{ response in
            self.eventHandler?(.stoploading)
            switch(response){
            case .success(let products):
                self.products=products
                self.eventHandler?(.dataloading)
//                print(products)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error)
            }
        }
    }
    
}

extension ProductViewModel{
    enum Event{
        case loading
        case dataloading
        case stoploading
        case error(Error?)
    }
}
