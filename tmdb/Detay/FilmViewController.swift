//
//  FilmViewController.swift
//  tmdb
//
//  Created by beyza nur on 24.10.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class FilmViewController: UIViewController {
    
    var selectedMovieTitle=" "
    var selectedMovieOverview=" "
    var selectedMovierelease_date=" "
    var selectedMovievote_average=Double()
    var selectedMovieposter_path=" "
    var fav=false
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        

        
        write()
        checkIfFavorite()
    }
    
    @IBAction func backButton(_ sender: Any) {
        //geri dönerken animasyon olsun istersk bunları yaparız
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.type = .fade
//        transition.subtype = .fromLeft
        
        let vc = storyboard?.instantiateViewController(identifier: "MPC") as! ViewController
//        vc.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func write() {
        imdbLabel.text=String(selectedMovievote_average)
        overViewLabel.text=selectedMovieOverview
        nameLabel.text=selectedMovieTitle
        dateLabel.text=selectedMovierelease_date
        let imageUrlString = "https://image.tmdb.org/t/p/w500\(selectedMovieposter_path ?? "")"
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
        firestoreDatabase.collection("FavoriteMovie")
            .whereField("title", isEqualTo: selectedMovieTitle)
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
        
        let firestoreFav = ["title": selectedMovieTitle, "overview": selectedMovieOverview, "date": selectedMovierelease_date, "imdb": selectedMovievote_average, "imageUrl": selectedMovieposter_path, "postedBy": currentUserID] as [String: Any]
        
        if favButton.tag == 0 {
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favButton.tag = 1
            
            firestoreDatabase.collection("FavoriteMovie").addDocument(data: firestoreFav) { error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    print("favorileme işlemi başarılı")
                }
            }
            
        }
        else{
            favButton.setImage(UIImage(systemName: "star"), for: .normal)
            favButton.tag = 0
            // Silmek istediğiniz koleksiyonun adı ve belgenin belirli kimliği (ID) ile referans oluşturun
            let favRef = firestoreDatabase.collection("FavoriteMovie").whereField("title", isEqualTo: selectedMovieTitle).whereField("postedBy", isEqualTo: currentUserID)
            
            favRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Favoriyi kaldırma hatası: \(error.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        firestoreDatabase.collection("FavoriteMovie").document(document.documentID).delete { (error) in
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
