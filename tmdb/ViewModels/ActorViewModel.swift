//
//  ActorViewModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

class ActorViewModel{
    var results=[ActorResults]()
    func FetchActor(completion:@escaping () ->Void){
        ActorWebServices.shared.FetchActor { results in
            guard let results=results else{
                return
            }
            self.results=results
            completion()
        }
    }
}
