//
//  PokemonDetailViewController.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - View Variable
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var horizontalStack: UIStackView!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomTableView: UITableView!
    
    var viewModel: PokemonDetailViewModel?
    var pokemonUrl: String = ""
    
    var selectedPokemon: Pokemon?
    var pokemonSelectedDetail: PokemonDetailResponse?
    
    let pokemonStatsName = ["HP", "Attack", "Defense", "Sp.Atk", "Sp.Def", "Spd"]
    
    fileprivate func setBackgroundLabel(type: String) -> UIColor {
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
    
    fileprivate func setupUITopView(forDistribution distribution: UIStackView.Distribution = .fillEqually, forSpacing spacing: CGFloat = 4) {
        horizontalStack.distribution = distribution
        horizontalStack.spacing = spacing
        horizontalStack.spacing = spacing
        verticalStack.distribution = distribution
        verticalStack.spacing = spacing
        topView.layer.cornerRadius = 16
        topView.layer.masksToBounds = true
        topView.addTopShadow(shadowHeight: 5)
    }
    
    fileprivate func setupUIBottomView() {
        bottomView.layer.cornerRadius = 16
        bottomView.layer.masksToBounds = true
        bottomView.addTopShadow(shadowHeight: 5)
        bottomTableView.delegate = self
        bottomTableView.dataSource = self
        bottomTableView.register(UINib(nibName: "PokemonMoveCell", bundle: nil), forCellReuseIdentifier: PokemonMoveCell.identifier)
        bottomTableView.clipsToBounds = true
        bottomTableView.layer.cornerRadius = 16
        
        bottomLabel.text = "Moves"
        bottomLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
    fileprivate func bindingView() {
        self.viewModel?.bindPokemonDetailData = { dataPokemonDetail in
            if let dataPokemonDetail = dataPokemonDetail {
                self.pokemonSelectedDetail = dataPokemonDetail
            }
            DispatchQueue.main.async {
                self.bottomTableView.reloadData()
            }
            
            self.pokemonImage.sd_setImage(with: URL(string: self.pokemonSelectedDetail?.sprites.other.home.frontDefault ?? ""))
            
            for i in 0..<(self.pokemonSelectedDetail?.stats.count ?? 0) {
                    let stackView = UIStackView()
                    stackView.alignment = .center
                    stackView.axis = .horizontal
                    stackView.distribution = .fill
                    stackView.contentMode = .scaleAspectFill
                    stackView.spacing = 4
                    
                    let statName = UILabel()
                    statName.text = self.pokemonStatsName[i]
                    statName.font = UIFont.systemFont(ofSize: 12, weight: .bold)
                    statName.textColor = self.setBackgroundLabel(type: self.pokemonSelectedDetail?.types[0].type.name ?? "")
                    
                    let statCount = UILabel()
                    let pokemonStat = self.pokemonSelectedDetail?.stats[i].baseStat ?? 0
                    statCount.text = "\(pokemonStat)"
                    statCount.textAlignment = .right
                    statCount.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                    
                    let progressView = UIProgressView(progressViewStyle: .bar)
                    progressView.center = self.verticalStack.center
                    progressView.setProgress(Float(pokemonStat) / 200.0, animated: true)
                    progressView.trackTintColor = UIColor(rgb: 0xF3F7F6)
                    progressView.tintColor = self.setBackgroundLabel(type: self.pokemonSelectedDetail?.types[0].type.name ?? "")
                    
                    stackView.addArrangedSubview(statName)
                    stackView.addArrangedSubview(statCount)
                    stackView.addArrangedSubview(progressView)
                    
                    statName.widthAnchor.constraint(equalToConstant: 64).isActive = true
                    statCount.widthAnchor.constraint(equalToConstant: 28).isActive = true
                    
                    
                    //                    statName.widthAnchor.constraint(equalToConstant: 64).isActive = true
                    self.verticalStack.addArrangedSubview(stackView)
                }
                
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
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = selectedPokemon?.name.capitalized
        
        if let url = selectedPokemon?.url {
            self.pokemonUrl = url
        }
        
        self.viewModel = PokemonDetailViewModel(urlString: pokemonUrl, apiService: ApiService())
        
        setupUITopView()
        setupUIBottomView()
        
        //MARK: - Binding
        bindingView()
        
        self.view.setGradientBackground()
    }
    
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bottomTableView.dequeueReusableCell(withIdentifier: PokemonMoveCell.identifier, for: indexPath) as? PokemonMoveCell else { return UITableViewCell()}
        cell.moveLabel.text = self.pokemonSelectedDetail?.moves[indexPath.row].move.name.capitalized
        cell.clipsToBounds = true
        cell.moveLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        cell.moveLabel.textColor = self.setBackgroundLabel(type: self.pokemonSelectedDetail?.types[0].type.name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonSelectedDetail?.moves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 28
    }
}
