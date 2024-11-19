//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 18/11/24.
//

import SwiftUI


class SplashViewModel:ObservableObject {
    @Published var uiState: SplashUIState = .loading
    
    
    func onAppear(){
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 4) {
            self.uiState = .goToSignInScreen
        }
    }
}
