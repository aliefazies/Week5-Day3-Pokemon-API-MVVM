//
//  ViewController.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 15/03/23.
//

import UIKit
import SDWebImage

class PokemonListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: PokemonListViewModel?
    
    private var pokemon: PokemonResponse?
    
    let url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=1000"
    
    fileprivate func setupCollectionView() {
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellWithReuseIdentifier: PokemonCell.identifier)
    }
    
    fileprivate func setupViewModel() {
        viewModel = PokemonListViewModel(urlString: url , apiService: ApiService())
        
        viewModel?.bindPokemonData = { dataPokemon in
            if let dataPokemon = dataPokemon {
                self.pokemon = dataPokemon
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.pokemon?.results.count ?? 0
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UICollectionViewCell() }
        
        cell.configurePokemonCell(pokemon: pokemon?.results[indexPath.row], indexPath: indexPath)
//        cell.setGradientBackground()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.size.width / 2.3, height: collectionView.frame.height / 5)
        return CGSize(width: 104, height: 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else { return }
        viewController.selectedPokemon = pokemon?.results[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

