//
//  ErrorResponse.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 20/11/24.
//

struct ErrorResponse: Decodable {
    let detail: String?
    
    enum CodingKeys:String, CodingKey {
       case detail
    }
}
