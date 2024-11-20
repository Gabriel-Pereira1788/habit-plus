//
//  CustomTextFieldStyle.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 20/11/24.
//


import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration.padding(.horizontal,8)
            .padding(.vertical,10)
            .overlay {
                RoundedRectangle(cornerRadius: 8.0).stroke(Color.orange, lineWidth: 0.8)
            }
    }
}
