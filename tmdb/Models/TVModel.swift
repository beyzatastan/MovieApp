//
//  TVModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation
struct TVModel:Codable{
    let results: [TVResults]
}

struct TVResults: Codable {
    let name:String
    let overview:String
    let first_air_date:String
    let vote_average:Double
    let poster_path: String?
}
