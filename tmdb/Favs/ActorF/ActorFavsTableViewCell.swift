//
//  ActorFavsTableViewCell.swift
//  tmdb
//
//  Created by beyza nur on 26.10.2023.
//

import UIKit

class ActorFavsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var favoriteactorimage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
