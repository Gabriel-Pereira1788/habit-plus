//
//  AuthRouter.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI
struct AuthRouterView: View {
    @ObservedObject var viewModel: AuthRouterViewModel
    var body: some View {
        ZStack {
            switch viewModel.uiState {
            case .goToHomeView:
                viewModel.homeView()
            case .goToSignInView:
                viewModel.signInView()
            }
        }
    }
}
