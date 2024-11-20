//
//  SignUpView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI

struct SignUpView:View {
    @ObservedObject var viewModel: SignUpViewModel
    
    
    
    var body: some View {
        ZStack {
            if case SignUpUIState.none = viewModel.uiState {
                ScrollView(showsIndicators:false){
                    VStack(alignment: .center,spacing: 10) {
                        
                        Text("Cadastro")
                            .foregroundColor(.black)
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        renderForm()
                        renderPicker()
                        renderSubmitButton()
                    }.padding(.horizontal,20)
                    
                    
                }.frame(maxHeight:.infinity)
            }
            
            
            if case SignUpUIState.error(let msg) = viewModel.uiState {
                Text("").alert(isPresented:.constant(true)){
                    Alert(title: Text("Habit"),message: Text(msg),dismissButton: .default(Text("Ok")))
                }
            }
        }
    }
}


extension SignUpView {
    func renderForm() -> some View {
        VStack(spacing: 15){
            
            EditTextView(text: viewModel.getFormValue(key: .email), placeholder: "Seu Email",keyboard: .emailAddress,error: "Campo invalido!",failure: !viewModel.validateField(key: .email))
            
            EditTextView(text: viewModel.getFormValue(key: .fullname), placeholder: "Seu nome completo",error: "Campo invalido!",failure: !viewModel.validateField(key: .fullname))
            
            EditTextView(text: viewModel.getFormValue(key: .phone), placeholder: "Telefone",keyboard: .numberPad,error: "Ente com seu DDD + 8 ou 9 digitos.",failure: !viewModel.validateField(key: .phone))
            
            EditTextView(text: viewModel.getFormValue(key: .document), placeholder: "Documento",keyboard: .numberPad,error: "Campo invalido!",failure: !viewModel.validateField(key: .document))
            
            
            EditTextView(text: viewModel.getFormValue(key: .birthdate), placeholder: "Data de nascimento",keyboard: .numberPad,error: "Data deve ser dd/mm/YYYY",failure: !viewModel.validateField(key: .birthdate))
            
            EditTextView(text: viewModel.getFormValue(key: .password), placeholder: "Senha",error: "Senha deve ter no minimo 8 caracteres.",failure: !viewModel.validateField(key: .password),secure: true)
            
        }
    }
    
}

extension SignUpView {
    func renderPicker() -> some View {
        Picker("Gender",selection: $viewModel.gender){
            ForEach(Gender.allCases) {
                value in
                Text(value.rawValue).tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
    }
}

extension SignUpView {
    func renderSubmitButton() -> some View {
        VStack{
            LoadingButtonView(action: {
                viewModel.singUp()
            }, disabled:viewModel.isDisabled(), showProgress: viewModel.uiState == SignUpUIState.loading, text: "Realize seu cadastro" )
        }
    }
}

#Preview {
    SignUpView(viewModel:SignUpViewModel())
}
