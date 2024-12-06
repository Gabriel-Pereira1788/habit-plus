//
//  AuthRouterViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//


import SwiftUI
import Combine

class AuthRouterViewModel:ObservableObject {
    @Published var uiState:AuthRouterUIState = .loading
    private var cancellable: AnyCancellable?
    private let routerPublisher = PassthroughSubject<AuthRouterUIState,Never>()
    
    private var interactor: RouterInteractor
    private var interactorCancellable: AnyCancellable?
    
    init(interactor:RouterInteractor) {
        self.interactor = interactor
        cancellable = routerPublisher.sink { value in
            
            self.uiState = value
        }
    }
    
    deinit {
        cancellable?.cancel()
        interactorCancellable?.cancel()
    }
    
    func onAppear(){
        interactorCancellable = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink {userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInView
                } else if (Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires)) {
                    
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        self.uiState = .goToHomeView
                    }
                }
                
            }
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
