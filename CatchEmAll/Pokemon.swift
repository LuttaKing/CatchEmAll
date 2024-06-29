//
//  Pokemon.swift
//  CatchEmAll
//
//  Created by Denilson Washuma on 26/06/2024.
//

import Foundation

struct PokeMon: Codable, Hashable {
    // VERY Important, JSON values are Codable. i.e they use encode and decode
    // Hashable is to allow iteration like with for each
    var name: String
    var url: String
    
    //check out coding keys: https://youtu.be/kzRyXYrDTRI
}
