//
//  PokemonDetailViewController.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonHPLabel: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var viewModel: PokemonDetailViewModel?
    var selectedPokemon: Pokemon?
    var pokemonSelectedDetail: PokemonDetailResponse?
    
    var pokemonUrl: String = ""
    
    var isHp: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
//        title = selectedPokemon?.name.capitalized
        pokemonNameLabel.text = selectedPokemon?.name
        if let pokemonDetail = selectedPokemon {
            pokemonUrl = "https://pokeapi.co/api/v2/pokemon/\( pokemonDetail.name)/"
        }
        
        self.viewModel = PokemonDetailViewModel(urlString: selectedPokemon!.url, apiService: ApiService())
        
        self.viewModel?.bindPokemonDetailData = { dataPokemonDetail in
            if let dataPokemonDetail = dataPokemonDetail {
                self.pokemonSelectedDetail = dataPokemonDetail
                
                self.isHp = self.pokemonSelectedDetail?.stats[0].baseStat ?? 0
                self.pokemonHPLabel.text = "\(self.isHp) HP"
                self.pokemonImage.sd_setImage(with: URL(string: self.pokemonSelectedDetail?.sprites.other.home.frontDefault ?? ""))
            }
        }
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colorTop = UIColor(rgb: 0x83ED6E).cgColor
        let colorBottom = UIColor(rgb: 0xf0f0f0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.background.bounds
                
        self.background.layer.insertSublayer(gradientLayer, at:0)
        self.background.layer.cornerRadius = 12
        self.background.layer.masksToBounds = true
    }
}
