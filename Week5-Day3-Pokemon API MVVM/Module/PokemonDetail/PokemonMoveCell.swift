//
//  PokemonMoveCell.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 20/03/23.
//

import UIKit

class PokemonMoveCell: UITableViewCell {

    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    static let identifier = "pokemonMoveCell"
    
    var viewModel: PokemonDetailViewModel?
    
    var pokemonMove: PokemonMove?
    
    func configure(moveUrl: String?) {
        guard let url = moveUrl else { return }
        self.viewModel = PokemonDetailViewModel(urlString: url, apiService: ApiService())
        
        self.viewModel?.bindPokemonMoveData = {
            dataMove in
            if let dataMove = dataMove {
                self.pokemonMove = dataMove
            }
            
            if let power = dataMove?.power {
                self.countLabel.text = "\(power)"
            } else if let accuracy = dataMove?.accuracy{
                self.countLabel.text = "\(accuracy)"
            } else if let pp = dataMove?.pp {
                self.countLabel.text = "\(pp)"
            }else {
                self.countLabel.text = ""
            }
            
        }
        self.moveLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
