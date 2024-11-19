//
//  SplashView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 18/11/24.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel:SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                renderLoadingView()
            case .goToHomeScreen:
                Text("HomeScreen")
            case .goToSignInScreen:
                Text("SignInScreen")
            case .error(let msg):
                renderLoadingView(error:msg)
            }
        }.onAppear(perform: viewModel.onAppear)
        
        
    }
}

extension SplashView {
    func renderLoadingView(error: String? = nil) -> some View {
        VStack {
            Image("logo")
            .resizable()
            .scaledToFit()
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .padding(20)
            .background(.white)
            .ignoresSafeArea()
        
        }.alert(isPresented:.constant(error != nil)){
            Alert(title: Text("Habit"),message:Text(error ?? ""),dismissButton: .default(Text("Ok!")){
                
            })
        }
    }
}

#Preview {
    let viewModel = SplashViewModel()
    SplashView(viewModel: viewModel)
}
