//
//  ViewController.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel=MovieViewModel()
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
    
        viewModel.FetchMovie {
            /*   burası ççalışıp çalışmadığını anlamak içindi
            for results in self.viewModel.results {
                print(results.title)
            }   */
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    

    
    
    @IBAction func tvButton(_ sender: Any) {
        let tVVC = storyboard?.instantiateViewController(identifier: "TVVC") as! TVViewController
        navigationController?.pushViewController(tVVC, animated: false)

    }
    
    @IBAction func actorButton(_ sender: Any) {
        let ActorVC = storyboard?.instantiateViewController(identifier: "ACTOR") as! ActorViewController
        navigationController?.pushViewController(ActorVC, animated: false)

        
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pmc", for: indexPath) as! PopularMovieCollectionViewCell
        let movie = viewModel.results[indexPath.row]
        cell.tittleLabel.text = movie.title
        cell.imdbLabel.text = "(\(String(movie.vote_average)))"
        
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(movie.poster_path ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            cell.imageView.image = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let selectedMovie=viewModel.results[indexPath.row]
        let filmVc=storyboard?.instantiateViewController(identifier: "film") as! FilmViewController
      //  filmVc.selectedFilm=seciliFilm
        filmVc.selectedMovieTitle = selectedMovie.title
        filmVc.selectedMovieOverview=selectedMovie.overview
        filmVc.selectedMovieposter_path=selectedMovie.poster_path ?? " "
        filmVc.selectedMovierelease_date=selectedMovie.release_date
        filmVc.selectedMovievote_average = Double(selectedMovie.vote_average)
        navigationController?.pushViewController(filmVc, animated: false)
    }
    
    
    @IBAction func settingsButton(_ sender: Any) {
        let settingsVc=storyboard?.instantiateViewController(identifier: "ayarlar") as! SettingsViewController
        navigationController?.pushViewController(settingsVc, animated: false)
    }
   
    
    @IBAction func favButton(_ sender: Any) {
        let favVc=storyboard?.instantiateViewController(identifier: "fav") as! FavViewController
        navigationController?.pushViewController(favVc, animated: false)
   
    }
}

