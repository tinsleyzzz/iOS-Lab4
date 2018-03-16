//
//  podexTableViewCell.swift
//  PokedexLab
//
//  Created by Tinsley Zhu on 3/16/18.
//  Copyright © 2018 iOS Decal. All rights reserved.
//

import UIKit

class podexTableViewCell: UITableViewCell {

    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var pokemonIndex: UILabel!
    @IBOutlet var pokemonKeyStats: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
