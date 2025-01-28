//
//  HabitUIState.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 06/01/25.
//

import Foundation

enum HabitUIState:Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
