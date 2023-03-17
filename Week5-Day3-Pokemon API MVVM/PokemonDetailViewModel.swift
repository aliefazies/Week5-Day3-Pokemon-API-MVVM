//
//  PokemonDetailViewModel.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import Foundation

protocol PokemonDetailViewModelProtocol {
    var urlString: String { get set }
    var bindPokemonDetailData: ((PokemonDetailResponse?) -> ())? {get set}
    func fetchDataPokemonDetail()
}

class PokemonDetailViewModel: PokemonDetailViewModelProtocol {
    
    private var apiService: ApiServiceProtocol?
    var data: PokemonDetailResponse?
    
    var urlString: String
    var bindPokemonDetailData: ((PokemonDetailResponse?) -> ())?
    
    
    init(urlString: String, apiService: ApiServiceProtocol) {
        self.urlString = urlString
        self.apiService = apiService
        
        if let url = URL(string: urlString) {
            self.apiService?.get(url: url)
        }
        fetchDataPokemonDetail()
    }
    
    func fetchDataPokemonDetail() {
        self.apiService?.loadPokemon(model: PokemonDetailResponse.self, completion: { response in
            switch response {
            case .success(let success):
                self.bindPokemonDetailData?(success)
            case .failure(_):
                self.bindPokemonDetailData?(nil)
            }
        })

    }
    
}
