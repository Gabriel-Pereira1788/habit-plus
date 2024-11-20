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
            AuthRouterView(viewModel: AuthRouterViewModel())
        }
    }
}
