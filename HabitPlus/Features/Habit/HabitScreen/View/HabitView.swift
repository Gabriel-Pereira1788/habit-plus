//
//  HabitView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 06/01/25.
//

import Foundation
import SwiftUI

struct HabitView:View {
    
    @ObservedObject var viewModel: HabitViewModel
    var body: some View {
        ZStack {
            
            
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        renderCommonHeader()
                        renderAddButton()
                        
                        switch viewModel.uiState {
                        case .loading:
                            renderLoading()
                        case .emptyList:
                            renderEmptyList()
                        case .error(let error):
                            Text("Error").alert(isPresented:.constant(true)) {
                                Alert(
                                    title:Text("Ops! \(error)"),
                                    message:Text("Tentar Novamente?"),
                                    primaryButton: .default(Text("Sim")) {
                                        viewModel.onAppear()
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            
                        case .fullList(let rows):
                            renderList(rows:rows)
                        }
                    }
                }.navigationTitle("Meus Hábitos")
            }
        }.onAppear{
            if !viewModel.opened {
                viewModel.onAppear()
            }
            
        }
    }
}

extension HabitView {
    func renderLoading() -> some View {
        ProgressView()
    }
    
    func renderList(rows:[HabitCardViewModel]) -> some View {
        LazyVStack {
            ForEach(rows,content:HabitCardView.init(viewModel:))
        }.padding(.horizontal,14)
    }
    
    func renderEmptyList() -> some View {
        
        VStack {
            Spacer(minLength: 60)
            Image(systemName: "exclamationmark.octagon.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text("Nenhum hábito encontrado")
        }
    }
}

extension HabitView {
    func renderCommonHeader() -> some View {
        VStack(alignment: .center, spacing:12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            Text(viewModel.title)
                .font(Font.system(.title).bold())
                .foregroundColor(Color.orange)
            
            Text(viewModel.subhead)
                .font(Font.system(.title3).bold())
                .foregroundColor(Color("textColor"))
            
            Text(viewModel.desc)
                .font(Font.system(.subheadline))
                .foregroundColor(Color("textColor"))
            
        }.frame(maxWidth: .infinity)
            .padding(.vertical,32)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray,lineWidth: 1)
            }
            .padding(.horizontal,16)
            .padding(.top,16)
    }
}

extension HabitView {
    
    func renderAddButton() -> some View {
        NavigationLink(destination:Text("Tela Adicionar").frame(maxWidth:.infinity,maxHeight: .infinity)) {
            Label("Criar Habito",systemImage: "plus.app")
                .modifier(ButtonStyle())
        }.padding(.horizontal,16)
    }
}
#Preview {
    HabitView(viewModel: HabitViewModel(interactor: HabitInteractor()))
}
