//
//  SignUpInteractor.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 03/12/24.
//

import Combine

class SignUpInteractor {
    private var remote:AuthDataSource = .shared
    private var local:AuthLocalDataSource = .shared
}

extension SignUpInteractor {
    func signup(signUpRequest request:SignUpRequest) -> Future<Bool,AppError> {
        return remote.createUser(request: request)
    }
    
    func signIn(signInRequest request: SignInRequest) -> Future<SignInResponse,AppError> {
        return remote.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        return local.insertUserAuth(userAuth: userAuth)
    }
}
