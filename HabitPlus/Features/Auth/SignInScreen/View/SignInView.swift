//
//  SignInView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SignInViewModel
    @State var navigationHidden = true
    @State var action:Int? = 0
    var body: some View {
        ZStack {
            NavigationView{
                ScrollView(showsIndicators:false) {
                    VStack(alignment: .center) {
                        Spacer(minLength: 100)
                        VStack(alignment:.center,spacing:8) {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 48)
                            
                            Text("Login")
                                .foregroundColor(.orange)
                                .font(Font.system(.title).bold())
                                .padding(.bottom,8)
                            
                            renderForm()
                            registerLink
                        }
                    }
                    
                }.frame(maxWidth:.infinity,maxHeight: .infinity)
                    .padding(.horizontal,32)
                    .background(Color.white)
                    .navigationBarTitle("Login", displayMode: .automatic)
                    .navigationBarHidden(navigationHidden)
                
                
            }.onAppear {
                self.navigationHidden = true
            }.onDisappear{
                self.navigationHidden = false
            }
            
            if case SignInUIState.error(let message) = viewModel.uiState  {
                ZStack {}.alert(isPresented: .constant(true)) {
                    Alert(title: Text("Habit"),message: Text(message),dismissButton: .default(Text("Ok")){
                        
                    })
                }
                
            }
        }
    }
}


extension SignInView {
    func renderForm() -> some View {
        VStack(spacing: 15){
            EditTextView(text:viewModel.getFormValue(key: .email), placeholder: "Email",keyboard: .emailAddress,error: "Campo invalido", failure: !viewModel.validateField(key: .email))
            
            EditTextView(text:viewModel.getFormValue(key: .password),placeholder: "Password", error:"Senha deve ter no minimo 8 caracteres",failure:!viewModel.validateField(key: .password),secure: true)
            
            LoadingButtonView(action: {
                viewModel.login()
            },
                              disabled: viewModel.isDisabled(),
                              showProgress: self.viewModel.uiState == SignInUIState.loading,
                              text: "Entrar")
            
        }.padding(20)
    }
}

extension SignInView {
    var registerLink: some View {
        VStack {
            Text("Ainda não possui um login ativo?")
                .foregroundColor(.gray)
                .padding(.top,48)
            
            ZStack {
                NavigationLink(
                    destination:viewModel.signInView(),
                    tag:1,
                    selection:$action,
                    label:{
                        EmptyView()
                    })
                Button("Realize seu Cadastro"){
                    self.action = 1
                }
            }
        }
    }
}


#Preview {
    SignInView(viewModel: SignInViewModel())
}

