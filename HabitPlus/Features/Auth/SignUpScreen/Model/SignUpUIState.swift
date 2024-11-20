//
//  SignUpUIState.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//


import Foundation

enum SignUpUIState: Equatable {
    case none
    case loading
    case success
    case error(msg:String)
}

enum KeySignUpForm: CaseIterable {
    case fullname
    case password
    case email
    case document
    case phone
    case birthdate
}

