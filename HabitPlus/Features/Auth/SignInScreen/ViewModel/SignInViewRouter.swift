//
//  SignInViewRouter.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//
import SwiftUI
import Combine

enum SignInViewRouter {
    static func makeHomeView() -> some View {
        return HomeView(viewModel: HomeViewModel())
    }
    
    static func makeSignUpView(routerPublisher: PassthroughSubject<AuthRouterUIState,Never>) -> some View {
        let viewModel = SignUpViewModel()
        viewModel.setRouterPublisher(routerPublisher)
        
        return SignUpView(viewModel:viewModel)
    }
    
}
