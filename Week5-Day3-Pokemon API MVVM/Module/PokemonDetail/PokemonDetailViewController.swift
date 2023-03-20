//
//  PokemonDetailViewController.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var horizontalStack: UIStackView!
    @IBOutlet weak var verticalStack: UIStackView!
    
    var viewModel: PokemonDetailViewModel?
    var selectedPokemon: Pokemon?
    var pokemonSelectedDetail: PokemonDetailResponse?
    
    var pokemonUrl: String = ""
    
    var isHp: Int = 0
    
    var pokemonStatsName = ["HP", "Attack", "Defense", "Sp.Atk", "Sp.Def", "Spd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = selectedPokemon?.name.capitalized
        
        if let pokemonDetail = selectedPokemon {
            pokemonUrl = "https://pokeapi.co/api/v2/pokemon/\( pokemonDetail.name)/"
        }
        
        self.viewModel = PokemonDetailViewModel(urlString: selectedPokemon?.url ?? "", apiService: ApiService())
        
        self.horizontalStack.distribution = .fillEqually
        self.horizontalStack.alignment = .top
        self.horizontalStack.spacing = 24
        self.verticalStack.distribution = .fillEqually
//        self.verticalStack.alignment = .top
        self.verticalStack.spacing = 2
        
        self.viewModel?.bindPokemonDetailData = { dataPokemonDetail in
            if let dataPokemonDetail = dataPokemonDetail {
                self.pokemonSelectedDetail = dataPokemonDetail
                
                self.isHp = self.pokemonSelectedDetail?.stats[0].baseStat ?? 0
                
                for i in 0..<(self.pokemonSelectedDetail?.stats.count ?? 0) {
                    let stackView = UIStackView()
                    stackView.alignment = .top
                    stackView.axis = .horizontal
                    stackView.distribution = .equalSpacing
                    stackView.contentMode = .scaleAspectFill
//                    stackView.spacing = 8
                    
                    let statName = UILabel()
                    statName.text = self.pokemonStatsName[i]
                    statName.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                    statName.textColor = self.setBackgroundLabel(type: self.pokemonSelectedDetail?.types[0].type.name ?? "")
                    
                    let statCount = UILabel()
                    let pokemonStat = self.pokemonSelectedDetail?.stats[i].baseStat ?? 0
                    statCount.text = "\(pokemonStat)"
                    statCount.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                    
                    stackView.addArrangedSubview(statName)
                    stackView.addArrangedSubview(statCount)
                    
//                    statName.widthAnchor.constraint(equalToConstant: 64).isActive = true
                    self.verticalStack.addArrangedSubview(stackView)
                }
                
                self.pokemonImage.sd_setImage(with: URL(string: self.pokemonSelectedDetail?.sprites.other.home.frontDefault ?? ""))
                
                
                for i in 0..<(self.pokemonSelectedDetail?.types.count ?? 0) {
                    let pokemonType = self.pokemonSelectedDetail?.types[i].type.name ?? ""
                    
                    
                    let typeLabel = PaddingLabel(withInsets: 8, 8, 8, 8)
                    typeLabel.layer.cornerRadius = 8
                    typeLabel.layer.masksToBounds = true
                    typeLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                    typeLabel.text = pokemonType
                    typeLabel.textAlignment = .center
                    typeLabel.backgroundColor = self.setBackgroundLabel(type: pokemonType)
                    typeLabel.textColor = UIColor.white
                    
                    self.horizontalStack.addArrangedSubview(typeLabel)
                }
            }
        }
        
        bottomView.layer.cornerRadius = 16
        bottomView.layer.masksToBounds = true
//        self.view.setGradientBackground()
        bottomView.addTopShadow(shadowHeight: 5)
        self.view.setGradientBackground()
    }
    
//    func setGradientBackground() {
//        let colorTop = UIColor(rgb: 0x83ED6E).cgColor
//        let colorBottom = UIColor(rgb: 0xf0f0f0).cgColor
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.frame = self.view.bounds
//
//        view.layer.insertSublayer(gradientLayer, at:0)
//        view.layer.cornerRadius = 12
//        view.layer.masksToBounds = true
//    }
    
    func setBackgroundLabel(type: String) -> UIColor {
        switch type {
        case "fire":
            return UIColor(rgb: 0xF57D31)
        case "grass":
            return UIColor(rgb: 0x74CB48)
        case "poison":
            return UIColor(rgb: 0xA43E9E)
        case "water":
            return UIColor(rgb: 0x6493EB)
        case "bug":
            return UIColor(rgb: 0xA7B723)
        case "flying":
            return UIColor(rgb: 0xA891EC)
        case "electric":
            return UIColor(rgb: 0xF9CF30)
        case "ghost":
            return UIColor(rgb: 0x70559B)
        case "normal":
            return UIColor(rgb: 0xAAA67F)
        case "psychic":
            return UIColor(rgb: 0xFB5584)
        case "steel":
            return UIColor(rgb: 0xB7B9D0)
        case "rock":
            return UIColor(rgb: 0xB69E31)
        default:
            return UIColor(rgb: 0x374151)
            
        }
    }
}
