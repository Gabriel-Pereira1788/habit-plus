import Foundation

enum HabitDetailsUIState:Equatable {
    case none
    case loading
    case success
    case error(String)
}

