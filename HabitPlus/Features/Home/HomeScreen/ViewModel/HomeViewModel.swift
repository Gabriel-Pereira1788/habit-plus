//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI

class HomeViewModel:ObservableObject {
    let habitViewModel = HabitViewModel(interactor: HabitInteractor())
}


extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
 }
