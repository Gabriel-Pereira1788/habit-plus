//
//  HomeView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 19/11/24.
//

import SwiftUI


struct HomeView:View {
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    var body: some View {
        renderTabView()
    }
}

extension HomeView {
    func renderTabView() -> some View{
        TabView(selection:$selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Habitos")
                }.tag(0)
            
            Text("Conteudo de graficos \(selection)")
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            
            
            
            Text("Conteudo de perfil \(selection)")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
            
        }.background(Color.white)
            .accentColor(.orange)
    }
}


#Preview {
    HomeView(viewModel: HomeViewModel())
}
