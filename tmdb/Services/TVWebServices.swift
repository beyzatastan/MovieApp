//
//  TVWebServices.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import Foundation

class TVWebServices{
    static let shared=TVWebServices()
    
    func FetchTV(completion:@escaping ([TVResults]?) -> Void){
        guard let urltv=URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=6bcb84141ec0a01262a37aacb02c1536") else{
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: urltv) { data, response, error in
            if error != nil{
                print(error?.localizedDescription)
            }else if let data=data{
                do{
                    let response = try JSONDecoder().decode(TVModel.self,from: data)
                    completion(response.results)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
