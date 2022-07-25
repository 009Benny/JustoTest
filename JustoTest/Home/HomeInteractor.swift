//
//  HomeInteractor.swift
//  JustoTest
//
//  Homed by Benny Reyes on 22/07/22.
//

import UIKit
import Alamofire

class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    
    // This method consume randomuser service that have information
    // to random users, and we send like parameter a number of specific
    // cant of user that I request
    func getUsers(cant:Int, completition: @escaping ServiceCompletition) {
        let url = "https://randomuser.me/api/?results=\(cant)"
        AF.request(url).responseDecodable(of: UserResponse.self) { response in
            guard let users = response.value else {
                completition(.failure(.ErrorNoData))
                return
            }
            completition(.success(users.results))
        }
    }
}
