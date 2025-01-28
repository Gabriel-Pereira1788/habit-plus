//
//  ButtonStyle.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 07/01/25.
//
import SwiftUI
import Foundation

struct ButtonStyle: ViewModifier {
    func body(content:Content) -> some View {
        content.frame(maxWidth: .infinity)
            .padding(.vertical,14)
            .padding(.horizontal,16)
            .font(Font.system(.title3).bold())
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(4.0)
            
    }
}
