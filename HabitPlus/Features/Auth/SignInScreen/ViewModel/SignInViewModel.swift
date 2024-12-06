//
//  SignInViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import Foundation
import Combine
import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var uiState: SignInUIState = .none
    @Published var form:[KeySignInForm:String] = [
        .email:"",
        .password:""
    ]
    
    private var routerPublisher:PassthroughSubject<AuthRouterUIState,Never>!
    private let interactor:SignInInteractor
    
    private var cancellableRequest: AnyCancellable?
    
    init(interactor:SignInInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func login(){
        uiState = .loading
        let signInData = SignInRequest(email: form[.email]!, password: form[.password]!)
        cancellableRequest = interactor.login(loginRequest:signInData).sink { completion in
            switch (completion) {
            case .failure(let appError):
                self.uiState = SignInUIState.error(message: appError.message)
                break
            case .finished:
                break
            }
            
        } receiveValue: { success in
            print(success)
            let auth = UserAuth(idToken: success.accessToken, refreshToken: success.refreshToken, expires: success.expires, tokenType: success.tokenType)
            
            self.interactor.insertAuth(userAuth: auth)
            self.routerPublisher.send(.goToHomeView)
        }
        
    }
    
    func setRouterPublisher(_ toRouterPubilsher:PassthroughSubject<AuthRouterUIState,Never>) {
        routerPublisher = toRouterPubilsher
    }
}


extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(routerPublisher: routerPublisher)
    }
}

extension SignInViewModel {
    func getFormValue(key:KeySignInForm) -> Binding<String>{
        return Binding(
            get:{self.form[key] ?? ""},
            set:{self.form[key] = $0}
        )
    }
    
    func validateField(key:KeySignInForm) -> Bool {
        switch(key){
        case .email:
            return form[.email]!.isEmail()
        case .password:
            return form[.password]!.count >= 8
        }
    }
    
    func isDisabled() -> Bool {
        return KeySignInForm.allCases.contains(where:{!validateField(key: $0)})
    }
}
