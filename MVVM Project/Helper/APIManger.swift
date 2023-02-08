//
//  APIManger.swift
//  MVVM Project
//
//  Created by Aman Verma on 08/02/23.
//

import Foundation
import UIKit

enum DataError:Error{
    case invalidResponse
    case invalidData
    case network(_ error:Error?)
}

typealias Handler=(Result<[Product],DataError>)->Void
final class APIManger{
    static let shared=APIManger()
    private init(){}
    
    func fetchroducts(completion: @escaping Handler){
        guard let url=URL(string:Constant.API.productURL)else{
            return
        }
    URLSession.shared.dataTask(with: url){
        data,response,error in
        guard let data,error==nil else {
            completion(.failure(.invalidData))
            return
        }
        guard let response = response as? HTTPURLResponse,200...299~=response.statusCode else{
            completion(.failure(.invalidResponse))
            return
        }
        
        do{
            let product=try JSONDecoder().decode([Product].self, from: data)
            completion(.success(product))
            
        }catch{
            completion(.failure(.invalidData))
        }
        
        
    }.resume()
        
        
}
}
