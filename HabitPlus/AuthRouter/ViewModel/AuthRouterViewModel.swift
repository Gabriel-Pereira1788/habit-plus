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
    private var refreshTokenCancellable: AnyCancellable?
    
    init(interactor:RouterInteractor) {
        self.interactor = interactor
        cancellable = routerPublisher.sink { value in
            
            self.uiState = value
        }
    }
    
    deinit {
        cancellable?.cancel()
        interactorCancellable?.cancel()
        refreshTokenCancellable?.cancel()
    }
    
    func onAppear(){
        
        interactorCancellable = interactor.fetchAuth()
            .receive(on: DispatchQueue.main)
            .sink {userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInView
                } else if (Date().timeIntervalSince1970 >  Double(userAuth!.expires)) {
                    
                    let refreshRequest = RefreshRequest(token: userAuth!.refreshToken)
                    self.refreshTokenCancellable = self.interactor.refreshToken(refreshRequest: refreshRequest)
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInView
                                break
                            default:break
                            }
                            
                            
                        } receiveValue: { success in
                            let auth = UserAuth(idToken: success.accessToken,
                                                refreshToken: success.refreshToken,
                                                expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                tokenType: success.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            self.uiState = .goToHomeView
                        }
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
