//
//  HomeEntity.swift
//  JustoTest
//
//  Homed by Benny Reyes on 22/07/22.
//

import Foundation

// MARK: - Network structs
typealias ServiceCompletition = (_ response:ResponseType)->()

enum ResponseType{
    case success(_ data:Any)
    case failure(_ message:MessagesStore)
}

enum JustoError: Error {
    case CantDecode
    case FailedConnection
}

// MARK: - User Model
struct UserResponse:Decodable{
    let results:[User]
    let info:Info
}

struct Info:Decodable{
    let seed:String
    let results:Int
    let page:Int
    let version:String
}

struct User:Decodable{
    let gender:String
    let name:String
    let fullName:String
    let email:String
    let phone:String
    let age:Int
    let cellphone:String
    let profilePicture:ImageModel
    let nationality:String
    
    enum CodingKeys: String, CodingKey {
        case gender, name, email, phone, cell, picture, nat, dob
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let name:NameModel = try container.decode(NameModel?.self, forKey: .name),
              let picture:ImageModel = try container.decode(ImageModel?.self, forKey: .picture),
              let age:DobModel = try container.decode(DobModel?.self, forKey: .dob)
        else{
            throw JustoError.CantDecode
        }
        self.gender = (try? container.decode(String.self, forKey: .gender)) ?? "undefined"
        self.name = name.first
        self.fullName = name.getFull()
        self.email = (try? container.decode(String.self, forKey: .email)) ?? "N/A"
        self.phone = (try? container.decode(String.self, forKey: .phone)) ?? "N/A"
        self.cellphone = (try? container.decode(String.self, forKey: .cell)) ?? "N/A"
        self.nationality = (try? container.decode(String.self, forKey: .nat)) ?? "undefined"
        self.age = age.age
        self.profilePicture = picture
        
    }
    
}

// Rest of the structs is only to decode data
struct NameModel:Decodable{
    let title:String
    let first:String
    let last:String
    
    func getFull()->String{
        return "\(title) \(first) \(last)"
    }
}

struct ImageModel:Decodable{
    let large:String
    let medium:String
    let thumbnail:String
}

struct DobModel:Decodable{
    let age:Int
}


