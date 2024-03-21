//
//  UserRepo.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 6.03.2024.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func getUsers() async throws -> [User]
}

final class NetworkManager: NetworkManagerProtocol {
    func getUsers() async throws -> [User] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        let request = URLRequest(url: url!)
        
        // _ is response
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let fetchedData = try JSONDecoder().decode([User].self, from: data)
        
        return fetchedData
    }
}
