import SwiftUI
import Foundation

class HabitDetailsViewModel:ObservableObject {
    @Published var uiState:HabitDetailsUIState = .none
    @Published var value = ""
    
    let id: Int
    let name: String
    let label: String
    
    init(id: Int, name: String, label: String) {
        self.id = id
        self.name = name
        self.label = label
    }
    
}
