//
//  ActorModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation
struct ActorModel:Codable{
    let results:[ActorResults]
    
}
struct ActorResults:Codable{
    var name:String
    var popularity:Double
    var profile_path:String?
    var known_for_department:String
}
