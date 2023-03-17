//
//  PokemonDetail.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 16/03/23.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let id: Int
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
}

struct Move: Codable {
    let move: OnlyName
}

struct StatClass: Codable {
    let name: String
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let home: Home
}

struct Home: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Stat: Codable {
    let baseStat: Int
    let stat: OnlyName
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct TypeElement: Codable {
    let slot: Int
    let type: OnlyName
}

struct OnlyName: Codable {
    let name: String
}
