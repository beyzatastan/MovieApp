//
//  TVFavsTableViewCell.swift
//  tmdb
//
//  Created by beyza nur on 26.10.2023.
//

import UIKit

class TVFavsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imdbLabel: UILabel!
    
    @IBOutlet weak var favoriteTvImageView: UIImageView!
    

    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
