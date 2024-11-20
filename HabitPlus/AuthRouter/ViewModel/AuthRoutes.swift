//
//  AuthRoutes.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import Combine
import SwiftUI

enum AuthRoutes {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
    static func makeSignInView(routerPublisher:PassthroughSubject<AuthRouterUIState,Never>) -> some View {
        let viewModel = SignInViewModel()
        viewModel.setRouterPublisher(routerPublisher)
        return SignInView(viewModel:viewModel)
    }
}
