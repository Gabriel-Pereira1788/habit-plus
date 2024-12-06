//
//  AuthLocalDataSource.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 05/12/24.
//

import Combine
import Foundation

class AuthLocalDataSource {
    static var shared = AuthLocalDataSource()
    private var localDataSource:LocalDataSource = .shared
    
    private init() {
        
    }
    
    func insertUserAuth(userAuth:UserAuth) {
        localDataSource.saveValue(key: "user_key", value: userAuth)
    }
    
    func getUserAuth() -> Future <UserAuth?,Never> {
        let userAuth:UserAuth? = localDataSource.readValue(forKey: "user_key")
        print(userAuth?.idToken ?? "NO TOKEN")
        return Future { promise in
            promise(.success(userAuth))
            
        }
    }
}
