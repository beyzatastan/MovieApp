//
//  FavTableViewCell.swift
//  tmdb
//
//  Created by beyza nur on 25.10.2023.
//

import UIKit

class FavTableViewCell: UITableViewCell {

   
    @IBOutlet weak var favoriteFilmimage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
