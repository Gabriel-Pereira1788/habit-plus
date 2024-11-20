//
//  SignInUIState.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import Foundation

enum SignInUIState: Equatable {
    case none
    case loading
    case error(message:String)
}


enum KeySignInForm:CaseIterable {
    case email
    case password
}
