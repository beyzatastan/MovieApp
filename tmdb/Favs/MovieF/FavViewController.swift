//
//  FavViewController.swift
//  tmdb
//
//  Created by beyza nur on 25.10.2023.
//

import UIKit
import Firebase

class FavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var movieNameArray=[String]()
    var movieImdbArray=[Double]()
    var movieUrl=[String]()
    var movieOverviewArray=[String]()
    var movieDate=[String]()
    
    var viewmodel=MovieViewModel()
    var documentIdArray=[String]()
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "movieFav", for: indexPath) as! FavTableViewCell
        cell.nameLabel.text=movieNameArray[indexPath.row]
        cell.imdbLabel.text=String(movieImdbArray[indexPath.row])
        
        
        let imageUrlStg = movieUrl[indexPath.row]
        let imageUrlString="https://image.tmdb.org/t/p/w500\(imageUrlStg ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let imagee = UIImage(data: imageData)
            cell.favoriteFilmimage.image=imagee
            
        }
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 234
    }
    
    //eğer favorisine tıklarsa ne olsun
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovieTitle = movieNameArray[indexPath.row]
        let selectedMovieVote=movieImdbArray[indexPath.row]
        let selectedMovieOverview=movieOverviewArray[indexPath.row]
        let selectedMovieDate=movieDate[indexPath.row]
        let selectedmovieImage=movieUrl[indexPath.row]
        
        
        let filmVc=storyboard?.instantiateViewController(identifier: "film") as! FilmViewController
    
        filmVc.selectedMovieTitle = selectedMovieTitle
        filmVc.selectedMovieOverview=selectedMovieOverview
        filmVc.selectedMovieposter_path=selectedmovieImage
        filmVc.selectedMovierelease_date=selectedMovieDate
        filmVc.selectedMovievote_average=selectedMovieVote
        navigationController?.pushViewController(filmVc, animated: false)
   
        
    }
    
   
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        getData()

       
    }
    

    @IBAction func homeButton(_ sender: Any) {
        let homesVc=storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
        navigationController?.pushViewController(homesVc, animated: false)
   
    }
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingsVc=storyboard?.instantiateViewController(identifier: "ayarlar") as! SettingsViewController
        navigationController?.pushViewController(settingsVc, animated: false)
   
    }
    
    
    @IBAction func tvButton(_ sender: Any) {
        let tvVc=storyboard?.instantiateViewController(withIdentifier: "tvfav") as! TVFavsViewController
        navigationController?.pushViewController(tvVc, animated: false)
  
    }
    
    
    @IBAction func actorButton(_ sender: Any) {
        let oyuncuVc=storyboard?.instantiateViewController(withIdentifier: "oyuncufav") as! ActorFavsViewController
        navigationController?.pushViewController(oyuncuVc, animated: false)
   
    }
    
    func getData(){
        let firestoreDatabase=Firestore.firestore()
        
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        firestoreDatabase.collection("FavoriteMovie").whereField("postedBy", isEqualTo: currentUserID).addSnapshotListener { snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                //DATA CEKME
                
                if let documents = snapshot?.documents {
                    
                    self.movieImdbArray.removeAll(keepingCapacity: false)
                    self.movieNameArray.removeAll(keepingCapacity: false)
                    
                    for document in documents {
                        let documentId=document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let movieName=document.get("title") as? String{
                            self.movieNameArray.append(movieName)
                        }
                        if let movierate=document.get("imdb") as? Double{
                            self.movieImdbArray.append(movierate)
                        }
                        guard let imageUrl = document.get("imageUrl") as? String else { return }
                        self.movieUrl.append(imageUrl)
                        
                        guard let movieOverview=document.get("overview") as? String else {return}
                        self.movieOverviewArray.append(movieOverview)
                        
                        guard let moviedate=document.get("date") as? String else {return}
                        self.movieDate.append(moviedate)
                    }
                        

                    
                }
                self.tableView.reloadData()
                
                
            }
        }
    }
    
    
    
}
