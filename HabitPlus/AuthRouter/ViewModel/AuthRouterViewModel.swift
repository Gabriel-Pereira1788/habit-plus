//
//  AuthRouterViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//


import SwiftUI
import Combine

class AuthRouterViewModel:ObservableObject {
    @Published var uiState = AuthRouterUIState.goToSignInView
    private var cancellable: AnyCancellable?
    private let routerPublisher = PassthroughSubject<AuthRouterUIState,Never>()
    
    init() {
        cancellable = routerPublisher.sink { value in
            
            self.uiState = value
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    
}

extension AuthRouterViewModel {
    func homeView() -> some View {
        return AuthRoutes.makeHomeView()
    }
    
    func signInView() -> some View {
        return AuthRoutes.makeSignInView(routerPublisher: routerPublisher)
    }
}
