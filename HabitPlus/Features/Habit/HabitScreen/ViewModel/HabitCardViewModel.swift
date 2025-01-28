//
//  HabitCardViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 07/01/25.
//

import Foundation
import SwiftUI

struct HabitCardViewModel:Identifiable,Equatable {
    var id: Int = 0
    var icon:String = ""
    var date:String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    var name : String = ""
    static func == (lhs: HabitCardViewModel, rhs: HabitCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
