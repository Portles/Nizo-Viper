//
//  Interactor.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import Foundation

protocol UserInteractorProtocol: AnyObject {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

final class UserInteractor: UserInteractorProtocol {
    static let shared: UserInteractor = UserInteractor()
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(NSError(domain: "URLCreationError", code: -1, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "DataError", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                completion(.success(entities))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
