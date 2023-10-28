//
//  TVFavsViewController.swift
//  tmdb
//
//  Created by beyza nur on 26.10.2023.
//

import UIKit
import Firebase

class TVFavsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var tvNameArray=[String]()
    var tvImdbArray=[Double]()
    var tvImage=[String]()
    var tvOverview=[String]()
    var tvDate=[String]()
    
    var documentIdArray=[String]()
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self

        getData()
       
    }
    
    @IBAction func actorButton(_ sender: Any) {
        
        let oyuncuVc=storyboard?.instantiateViewController(withIdentifier: "oyuncufav") as! ActorFavsViewController
        navigationController?.pushViewController(oyuncuVc, animated: false)
   
        
    }
    @IBAction func movieButton(_ sender: Any) {
        let movieVc=storyboard?.instantiateViewController(withIdentifier: "fav") as! FavViewController
        navigationController?.pushViewController(movieVc, animated: false)
   
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let homesVc=storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
        navigationController?.pushViewController(homesVc, animated: false)
    }
    

    @IBAction func settingsButton(_ sender: Any) {
        let settingsVc=storyboard?.instantiateViewController(identifier: "ayarlar") as! SettingsViewController
        navigationController?.pushViewController(settingsVc, animated: false)

    }
    
    func getData(){
        let firestoreDatabase=Firestore.firestore()
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        firestoreDatabase.collection("FavoriteTV").whereField("postedBy", isEqualTo: currentUserID).addSnapshotListener{ snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                //DATA CEKME
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.tvImdbArray.removeAll(keepingCapacity: false)
                    self.tvNameArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        let documentId=document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let tvName=document.get("title") as? String{
                            self.tvNameArray.append(tvName)
                        }
                        if let tvRate=document.get("imdb") as? Double{
                            self.tvImdbArray.append(tvRate)
                        }
                        guard let imageUrl = document.get("imageUrl") as? String else { return }
                        self.tvImage.append(imageUrl)
                        
                        guard let tvoverview=document.get("overview") as? String else {return}
                        self.tvOverview.append(tvoverview)
                        
                        guard let tvdate=document.get("date") as? String else {return}
                        self.tvDate.append(tvdate)
                  
                       
                  
                        
                    }
                }
                self.tableView.reloadData()
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTVTittle = tvNameArray[indexPath.row]
        let selectedTvVote=tvImdbArray[indexPath.row]
        let selectedTVOverview=tvOverview[indexPath.row]
        let selectedTVDate=tvDate[indexPath.row]
        let selectedTVImage=tvImage[indexPath.row]
        
        
        let diziVc=storyboard?.instantiateViewController(identifier: "dizi") as! DiziViewController
    
        diziVc.selectedTvTitle = selectedTVTittle
        diziVc.selectedTVOverview=selectedTVOverview
        diziVc.selectedTvposter_path=selectedTVImage
        diziVc.selectedTvrelease_date=selectedTVDate
        diziVc.selectedTvvote_average=selectedTvVote
        navigationController?.pushViewController(diziVc, animated: false)
   
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tvFav", for: indexPath) as! TVFavsTableViewCell
        cell.nameLabel.text=tvNameArray[indexPath.row]
        cell.imdbLabel.text=String(tvImdbArray[indexPath.row])
        
        
        let imageUrlStg = tvImage[indexPath.row]
        let imageUrlString="https://image.tmdb.org/t/p/w500\(imageUrlStg ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let imagee = UIImage(data: imageData)
            cell.favoriteTvImageView.image=imagee
            
            
        }
        return cell
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 234
    }
    
}
