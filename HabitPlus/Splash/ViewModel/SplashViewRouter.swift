//
//  SplashViewRouter.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        return SignInView(viewModel: SignInViewModel())
    }
}
