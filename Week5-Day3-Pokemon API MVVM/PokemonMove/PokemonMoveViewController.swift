//
//  PokemonMoveViewController.swift
//  Week5-Day3-Pokemon API MVVM
//
//  Created by Alief Ahmad Azies on 21/03/23.
//

import UIKit

class PokemonMoveViewController: UIViewController {
    
    @IBOutlet weak var urlLabel: UILabel!
    
    var pokemonMoveUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        urlLabel.text = pokemonMoveUrl ?? ""
    }
}
