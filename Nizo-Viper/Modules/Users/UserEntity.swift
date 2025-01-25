//
//  Entity.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

struct User: Codable, Equatable {
    let name: String
    
    static let mockUsers: [Self] = [
        Self(name: "Nizometto"),
        Self(name: "Mertcanto")
    ]
}
