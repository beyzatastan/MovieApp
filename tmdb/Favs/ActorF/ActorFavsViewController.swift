//
//  ActorFavsViewController.swift
//  tmdb
//
//  Created by beyza nur on 26.10.2023.
//

import UIKit
import Firebase

class ActorFavsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var actorNameArray=[String]()
    var actorPopularityArray=[Double]()
    var actorImage=[String]()
    var actorJob=[String]()
    var documentIdArray=[String]()
    
    
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
    
    
    @IBAction func movieButton(_ sender: Any) {
        let movieVc=storyboard?.instantiateViewController(withIdentifier: "fav") as! FavViewController
        navigationController?.pushViewController(movieVc, animated: false)
   
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorNameArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "actorfav", for: indexPath) as! ActorFavsTableViewCell
        cell.nameLabel.text=actorNameArray[indexPath.row]
        cell.popularityLabel.text=String(actorPopularityArray[indexPath.row])
        
        
        let imageUrlStg = actorImage[indexPath.row]
        let imageUrlString="https://image.tmdb.org/t/p/w500\(imageUrlStg ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let imagee = UIImage(data: imageData)
            cell.favoriteactorimage.image=imagee
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedActorName = actorNameArray[indexPath.row]
        let selectedActorPopularity=actorPopularityArray[indexPath.row]
        let selectedActorJob=actorJob[indexPath.row]
        let selectedActorImage=actorImage[indexPath.row]
        
        
        let actorVc=storyboard?.instantiateViewController(identifier: "oyuncu") as! OyuncuViewController
    
        actorVc.selectedActorName = selectedActorName
        actorVc.selectedActorImage=selectedActorImage
        actorVc.selectedActorDepartmant=selectedActorJob
        actorVc.selectedActorPopularity=selectedActorPopularity
        navigationController?.pushViewController(actorVc, animated: false)
   
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 234
    }
    
    func getData(){
        let firestoreDatabase=Firestore.firestore()
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        firestoreDatabase.collection("FavoriteActor").whereField("postedBy", isEqualTo: currentUserID).addSnapshotListener{ snapshot, error in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                //DATA CEKME
                
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.actorPopularityArray.removeAll(keepingCapacity: false)
                    self.actorNameArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in snapshot!.documents{
                        let documentId=document.documentID
                        self.documentIdArray.append(documentId)
                        
                        if let actorName=document.get("title") as? String{
                            self.actorNameArray.append(actorName)
                        }
                        if let actorPopularity=document.get("popularity") as? Double{
                            self.actorPopularityArray.append(actorPopularity)
                        }
                        guard let imageUrl = document.get("imageUrl") as? String else { return }
                        self.actorImage.append(imageUrl)
                        
                        guard let actorjob=document.get("job") as? String else {return}
                        self.actorJob.append(actorjob)
                  
                        
                    }
                }
                self.tableView.reloadData()
                
            }
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
