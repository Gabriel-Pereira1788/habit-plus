//
//  UserAuth.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 05/12/24.
//

struct UserAuth:Codable {
    var idToken:String
    var refreshToken:String
    var expires: Double = 0
    var tokenType:String
    
    enum CodingKeys:String,CodingKey {
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
