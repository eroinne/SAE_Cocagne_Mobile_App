//
//  DetailTourneeLivraison.swift
//  Sae_Cocagne
//
//  Created by Ero on 12/03/2024.
//  Copyright © 2024 random. All rights reserved.
//

import Foundation
import UIKit

struct DetailLivraison: Codable, Hashable {
    let count: String
    let panier_id: String
    let panier: String
    let adherents: [Int]
}

struct DetailDistribution: Codable, Hashable {
    let distribution_id: String
    let depot_id: String
    let depot: String
    let ordre: Int
    let capacite: Int
    var adresse: String
    let codepostal: String
    let ville: String
    let st_x: Double
    let st_y: Double
    let livraisons: [DetailLivraison]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.distribution_id = try container.decode(String.self, forKey: .distribution_id)
        self.depot_id = try container.decode(String.self, forKey: .depot_id)
        self.depot = try container.decode(String.self, forKey: .depot)
        self.ordre = try container.decode(Int.self, forKey: .ordre)
        self.capacite = try container.decode(Int.self, forKey: .capacite)
        self.adresse = "non fournie" // Valeur par défaut si l'adresse est nulle
        // Traitement pour les valeurs nulles
                self.adresse = try container.decodeIfPresent(String.self, forKey: .adresse) ?? "non fournie"
                self.codepostal = try container.decodeIfPresent(String.self, forKey: .codepostal) ?? "non fournie"
                self.ville = try container.decodeIfPresent(String.self, forKey: .ville) ?? "non fournie"
                self.st_x = try container.decodeIfPresent(Double.self, forKey: .st_x) ?? 0.0
                self.st_y = try container.decodeIfPresent(Double.self, forKey: .st_y) ?? 0.0
               
        self.livraisons = try container.decode([DetailLivraison].self, forKey: .livraisons)
    }
}


struct DetailTourneeLivraison: Codable, Hashable {
    let tournee_id: String
    let tournee: String
    let preparation_id: String
    let calendrier_id: String
    let ordre: Int
    let couleur: String
    let distribution: [DetailDistribution]
    
    
    
    
}
