//
//  HabitPlusApp.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 18/11/24.
//

import SwiftUI

@main
struct HabitPlusApp: App {
    var body: some Scene {
        WindowGroup {
            renderRouter()
        }
    }
    
    func renderRouter() -> some View {
        let viewModel = AuthRouterViewModel(interactor: RouterInteractor())
        return AuthRouterView(viewModel: viewModel)
    }
}



