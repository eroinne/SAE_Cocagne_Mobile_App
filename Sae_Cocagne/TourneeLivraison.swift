//
//  TourneeLivraison.swift
//  Sae_Cocagne
//
//  Created by Ero on 01/03/2024.
//

import Foundation

struct TourneeLivraison: Identifiable, Codable, Hashable {    
    var id: Int
    var jardin_id: Int
    var tournee: String
    var preparation_id: Int
    var calendrier_id: Int
    var ordre: Int
    var couleur : String
    
    
    enum CodingKeys: String, CodingKey {
            case id = "tournee_id"
            case jardin_id
            case tournee
            case preparation_id
            case calendrier_id
            case ordre
            case couleur
        }
}
