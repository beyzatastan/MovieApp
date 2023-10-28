//
//  MovieViewModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

class MovieViewModel{
    //modeldeki results
    var results=[Results]()
    
    func FetchMovie(completion:@escaping () ->Void){
        WebService.shared.FetchMovie { results in
            guard let results=results else{
                return
            }
            self.results=results
            completion()
        }
    }
}
