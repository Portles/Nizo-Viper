//
//  Entity.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

struct User: Codable {
    let name: String
    
    static let mockUsers: [User] = [
        User(name: "Nizometto"),
        User(name: "Mertcanto")
    ]
}
