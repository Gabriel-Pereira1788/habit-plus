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
    func fetchAuth() -> Future<UserAuth?,Never> {
        return local.getUserAuth()
    }
}
