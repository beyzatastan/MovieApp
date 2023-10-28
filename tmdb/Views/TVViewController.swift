//
//  TVViewController.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import UIKit

class TVViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //önce vie3wmodel i tanıtıyoruz
    var tvModel=TVViewModel()
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //back tuşunu sildik
        navigationController?.navigationBar.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tvModel.FetchTV {
            /*   burası ççalışıp çalışmadığını anlamak içindi
             
             for results in self.tvModel.results {
             print(results.name)
             }  */
            
            
            //data geldikçe collection view u yenile
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func movieButton(_ sender: Any) {
        
        let MovieVC = storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
        navigationController?.pushViewController(MovieVC, animated: false)

    }
    
    
 
    @IBAction func actorButton(_ sender: Any) {
        let ActorVC = storyboard?.instantiateViewController(identifier: "ACTOR") as! ActorViewController
        navigationController?.pushViewController(ActorVC, animated: false)

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //view modeldeki listemizde ne kadar eleman varsa
        return tvModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "tvc", for: indexPath) as! TVCollectionViewCell
        let tv=tvModel.results[indexPath.row]
        cell.tittleLabel.text=tv.name
        cell.imdbLabel.text=String(tv.vote_average)
        
        let imageUrlStringtv="https://image.tmdb.org/t/p/w500\(tv.poster_path ?? "")"
        
        if let imageUrl=URL(string: imageUrlStringtv),let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            cell.imageView.image=image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        let selectedTv=tvModel.results[indexPath.row]
        let TvVc=storyboard?.instantiateViewController(identifier: "dizi") as! DiziViewController
        navigationController?.pushViewController(TvVc, animated: false)
        TvVc.selectedTvTitle=selectedTv.name
        TvVc.selectedTVOverview=selectedTv.overview
        TvVc.selectedTvrelease_date=selectedTv.first_air_date
        TvVc.selectedTvvote_average=selectedTv.vote_average
        TvVc.selectedTvposter_path=selectedTv.poster_path ?? " "
        
        
    }
    
    
    @IBAction func homeButton(_ sender: Any) {
        let homesVc=storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
        navigationController?.pushViewController(homesVc, animated: false)
   
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
