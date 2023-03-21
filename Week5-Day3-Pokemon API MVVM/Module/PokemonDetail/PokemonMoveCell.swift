//
//  PokemonMoveCell.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 20/03/23.
//

import UIKit

class PokemonMoveCell: UITableViewCell {

    @IBOutlet weak var moveLabel: UILabel!
    
    static let identifier = "pokemonMoveCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
