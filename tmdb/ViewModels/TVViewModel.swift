//
//  TVViewModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

class TVViewModel{
    //modeldeki results
    var results=[TVResults]()
    
    func FetchTV(completion:@escaping () ->Void){
        TVWebServices.shared.FetchTV { results in
            guard let results=results else{
                return
            }
            self.results=results
            completion()
        }
    }
   
}
