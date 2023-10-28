//
//  DiziViewController.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import UIKit
import Firebase

class DiziViewController: UIViewController {

    
    var selectedTvTitle=" "
    var selectedTVOverview=" "
    var selectedTvrelease_date=" "
    var selectedTvvote_average=Double()
    var selectedTvposter_path=" "
    
    
    

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        
       write()
        checkIfFavorite()
        
    
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "TVVC") as! TVViewController
    //        vc.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(vc, animated: false)

    }
    
    
    func write(){
        imdbLabel.text=String(selectedTvvote_average)
        nameLabel.text=selectedTvTitle
        overviewLabel.text=selectedTVOverview
        dateLabel.text=selectedTvrelease_date
        
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(selectedTvposter_path ?? "")"
        if let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
            let image = UIImage(data: imageData)
            imageView.image=image
        }
    }
    
    func checkIfFavorite() {
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        let firestoreDatabase = Firestore.firestore()
        
        // Favori filmi veritabanında kontrol et
        firestoreDatabase.collection("FavoriteTV")
            .whereField("title", isEqualTo: selectedTvTitle)
            .whereField("postedBy", isEqualTo: currentUserID)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Favori kontrol hatası: \(error.localizedDescription)")
                } else {
                    if querySnapshot!.documents.isEmpty {
                        // Favori değil
                        self.favButton.setImage(UIImage(systemName: "star"), for: .normal)
                        self.favButton.tag = 0
                    } else {
                        // Favori
                        self.favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                        self.favButton.tag = 1
                    }
                }
            }
    }

    
    @IBAction func favButton(_ sender: Any) {
        
        
        guard let user = Auth.auth().currentUser else { return }
        let currentUserID = user.uid
        
        let firestoreDatabase = Firestore.firestore()
        
        let firestoreFav = ["title": selectedTvTitle, "overview": selectedTVOverview, "date": selectedTvrelease_date, "imdb": selectedTvvote_average, "imageUrl": selectedTvposter_path, "postedBy": currentUserID] as [String: Any]
        
        
        if favButton.tag == 0 {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favButton.tag = 1
            //DATABASE
            
            
            
            firestoreDatabase.collection("FavoriteTV").addDocument(data: firestoreFav) { error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("favorileme işlemi başarılı")
                }
            }
        
            
            
        } else {
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            favButton.tag = 0
            // Silmek istediğiniz koleksiyonun adı ve belgenin belirli kimliği (ID) ile referans oluşturun
            let favRef = firestoreDatabase.collection("FavoriteTV").whereField("title", isEqualTo: selectedTvTitle).whereField("postedBy", isEqualTo: currentUserID)
            
            favRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Favoriyi kaldırma hatası: \(error.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        firestoreDatabase.collection("FavoriteTV").document(document.documentID).delete { (error) in
                            if let error = error {
                                print("Favoriyi kaldırma hatası: \(error.localizedDescription)")
                            } else {
                                print("Favori kaldırıldı")
                            }
                        }
                    }
                    
                }
                
                
            }
            
        }
    }
}
