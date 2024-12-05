//
//  AppError.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 03/12/24.
//

import Foundation

enum AppError:Error {
    case response(message:String)
    
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
