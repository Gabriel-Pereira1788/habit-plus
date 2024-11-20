//
//  EditTextView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 20/11/24.
//

import SwiftUI


struct EditTextView: View {
    @Binding var text:String
    var placeholder:String
    var keyboard:UIKeyboardType = .default
    var error:String? = nil
    var failure: Bool? = nil
    var secure: Bool? = nil
    
    var body: some View {
        VStack{
            if secure == true {
                SecureField(placeholder,text:$text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder,text:$text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            
            if let error = error,failure == true ,!text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }.padding(.bottom,10)
        
    }
}


#Preview {
    VStack{
        EditTextView(text: .constant("a"), placeholder: "E-mail", error: "Campo invalido",failure: true,secure: true)
    }.padding(10)
    
}
