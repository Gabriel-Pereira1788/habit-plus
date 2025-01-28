//
//  HomeViewRouter.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 06/01/25.
//


import SwiftUI
import Foundation

enum HomeViewRouter {
    
    static func makeHabitView(viewModel:HabitViewModel) -> some View {
//        let viewModel = HabitViewModel(interactor: HabitInteractor())
        return HabitView(viewModel: viewModel)
    }
}
