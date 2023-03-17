//
//  PokemonCell.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 15/03/23.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    static let identifier = "pokemonCell"
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurePokemonCell(pokemon: Pokemon?, indexPath: IndexPath) {
        if let pokemon = pokemon {
            pokemonNameLabel.text = pokemon.name.capitalized
            pokemonImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(indexPath.row + 1).png"))
    
            pokemonImage.contentMode = .scaleAspectFit
        }
        
        background.layer.cornerRadius = 6
        background.layer.masksToBounds = true
//        background.layer.borderWidth = 1
//        background.layer.borderColor = UIColor.black.cgColor
    }
    
    func setGradientBackground() {
//        let colorTop =  UIColor(red: 238.0/255.0, green: 21.0/255.0, blue: 21.0/255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let colorTop = UIColor(rgb: 0x83ED6E).cgColor
        let colorBottom = UIColor(rgb: 0xf0f0f0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.background.bounds
                
        self.background.layer.insertSublayer(gradientLayer, at:0)
    }
}
