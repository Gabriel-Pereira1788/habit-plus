//
//  RefreshRequest.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 17/12/24.
//

struct RefreshRequest:Encodable {
    let token:String
    enum CodingKeys:String, CodingKey {
        case token
    }
}
