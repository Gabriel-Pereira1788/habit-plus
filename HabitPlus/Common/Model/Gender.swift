//
//  Gender.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

enum Gender:String, CaseIterable, Identifiable {
    var id: Self {self}
    case male = "Masculino"
    case female = "Femino"
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex {
            self == $0
        } ?? 0
    }
}
