//
//  ActorViewController.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import UIKit

class ActorViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var actorModel=ActorViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
        
        

        
        actorModel.FetchActor {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func movieButton(_ sender: Any) {
        let MovieVC = storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
        navigationController?.pushViewController(MovieVC, animated: false)

    }
    
    @IBAction func tvButton(_ sender: Any) {
        let tVVC = storyboard?.instantiateViewController(identifier: "TVVC") as! TVViewController
        navigationController?.pushViewController(tVVC, animated: false)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  actorModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "avc", for: indexPath) as! ActorCollectionViewCell
        let actor=actorModel.results[indexPath.row]
        cell.nameLabel.text=actor.name
        cell.imdbLabel.text=actor.known_for_department
        
        let imageUrlStringtv="https://image.tmdb.org/t/p/w500\(actor.profile_path ?? "")"
        
        if let imageUrl=URL(string: imageUrlStringtv),let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            cell.imageView.image=image
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedActor=actorModel.results[indexPath.row]
        let ActorVc=storyboard?.instantiateViewController(identifier: "oyuncu") as! OyuncuViewController
      //  filmVc.selectedFilm=seciliFilm

        navigationController?.pushViewController(ActorVc, animated: false)
        
           ActorVc.selectedActorName=selectedActor.name
        ActorVc.selectedActorDepartmant=selectedActor.known_for_department
        ActorVc.selectedActorPopularity=selectedActor.popularity
        ActorVc.selectedActorImage=selectedActor.profile_path ?? " "
        
        
    }
    
    
    @IBAction func favButton(_ sender: Any) {
        let favVc=storyboard?.instantiateViewController(identifier: "fav") as! FavViewController
        navigationController?.pushViewController(favVc, animated: false)
   
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingsVc=storyboard?.instantiateViewController(identifier: "ayarlar") as! SettingsViewController
        navigationController?.pushViewController(settingsVc, animated: false)
  
    }
    
}
