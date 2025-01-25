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
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return []
        }
        
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        var fetchedData: [User] = []
        
        fetchedData = try JSONDecoder().decode([User].self, from: data)
        
        return fetchedData
    }
}
