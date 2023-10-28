//
//  MovieWebServices.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

class WebService{
    static let shared = WebService()
    
    //veri çekilcek fonk
    func FetchMovie(completion:@escaping ([Results]?) -> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6bcb84141ec0a01262a37aacb02c1536") else{
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }else if let data=data{
                do{
                    let response = try JSONDecoder().decode(MovieModel.self, from: data)
                    completion(response.results)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
