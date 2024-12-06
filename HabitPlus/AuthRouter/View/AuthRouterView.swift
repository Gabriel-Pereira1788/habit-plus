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
            case .loading:
                renderLoadingView()
            case .goToHomeView:
                viewModel.homeView()
            case .goToSignInView:
                viewModel.signInView()
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}


extension AuthRouterView {
    
    func renderLoadingView() -> some View {
        VStack {
            Image("logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .padding(20)
            .background(.white)
            .ignoresSafeArea()
        
        }
    }
}
