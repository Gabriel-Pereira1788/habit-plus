//
//  RouterInteractor.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 06/12/24.
//

import SwiftUI
import Combine

class RouterInteractor {
    private var local: AuthLocalDataSource = .shared
    private var remote: RouterRemoteDataSource = .shared
    func fetchAuth() -> Future<UserAuth?,Never> {
        return local.getUserAuth()
    }
    
    func refreshToken(refreshRequest request: RefreshRequest) -> Future<SignInResponse,AppError> {
        return remote.refreshToken(request: request)
    }
    
    func insertAuth(userAuth:UserAuth) {
        local.insertUserAuth(userAuth: userAuth)
    }
}
