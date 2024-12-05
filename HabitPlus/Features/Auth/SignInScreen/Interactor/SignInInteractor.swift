//
//  SignInInteractor.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 03/12/24.
//
import Combine

class SignInInteractor {
    private let remote: AuthDataSource = .shared
    private let local: AuthLocalDataSource = .shared
}
    

extension SignInInteractor {
    func login(loginRequest request:SignInRequest) -> Future<SignInResponse, AppError> {
        return remote.login(request: request)
    }
    
    func insertAuth(userAuth:UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
    
    func fetchAuth() -> Future<UserAuth?,Never> {
        return local.getUserAuth()
    }
}
