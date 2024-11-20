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

    
    func login(){
        uiState = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.routerPublisher.send(AuthRouterUIState.goToHomeView)
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
    
    func signInView() -> some View {
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
            return form[.password]!.count > 8
        }
    }
    
    func isDisabled() -> Bool {
        return KeySignInForm.allCases.contains(where:{!validateField(key: $0)})
    }
}
