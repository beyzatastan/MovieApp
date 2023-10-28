//
//  MovieModel.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

struct MovieModel:Codable{
    let results: [Results]
}

struct Results: Codable {
    let title:String
    let overview:String
    let release_date:String
    let vote_average:Double
    let poster_path: String?
}
