//
//  Depot.swift
//  Sae_Cocagne
//
//  Created by Ero on 08/03/2024.
//  Copyright © 2024 random. All rights reserved.
//

import Foundation


struct Depot: Identifiable, Codable {
    var id: Int
    var jardin_id: Int
    var depot: String
    var adresse_id: Int
    var contact_id: Int
    var capacite: Int
}
