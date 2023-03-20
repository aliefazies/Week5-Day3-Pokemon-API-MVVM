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
    
    @IBOutlet weak var bottomBg: UIView!
    
    @IBOutlet weak var card: UIView!
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
        
        background.layer.cornerRadius = 8
        background.layer.masksToBounds = true
        bottomBg.layer.cornerRadius = 16
        bottomBg.layer.masksToBounds = true
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowColor = UIColor.black.cgColor
//        card.layer.borderWidth = 1
//        card.layer.borderColor = UIColor.black.cgColor
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
