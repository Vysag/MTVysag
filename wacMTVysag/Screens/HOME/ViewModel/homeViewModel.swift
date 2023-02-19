//
//  homeViewModel2.swift
//  wacMTVysag
//
//  Created by vysag k on 19/02/23.
//

import Foundation
import SwiftUI

class homeViewModel: ObservableObject, Identifiable {
    @Published  var data = [HomeData]()
    @Published var isLoading:Bool = true
    func getProducts() async{
        
        APIManager.shared.fetchProducts{ response in
            switch response{
            case .success(let home):
                DispatchQueue.main.async{
                    self.data = home.homeData
                    self.isLoading = false
                    
                   
                    
                }
               print(home)
            case .failure(let error):
                print(error)
            }
        }
    }
                   
}
