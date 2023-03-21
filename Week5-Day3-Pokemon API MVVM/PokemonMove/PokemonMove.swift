//
//  PokemonMove.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 21/03/23.
//

import Foundation

// MARK: - PokemonMove
struct PokemonMove: Codable {
    let accuracy, id: Int
    let name: String
    let power, pp: Int
}
