//
//  HabitCardView.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 07/01/25.
//

import SwiftUI

struct HabitCardView:View {
    @State private var action = false
    let viewModel:HabitCardViewModel
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink(
                destination: HabitDetailsView(viewModel: HabitDetailsViewModel(id:viewModel.id,name:viewModel.name,label:viewModel.label)), isActive: self.$action, label: {
                    EmptyView()
                }
            )
            
            Button(action: {
                self.action = true
            }, label: {
                
                HStack {
                    Image(systemName: "pencil")
                        .padding(.horizontal,8)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Spacer()
                        VStack(alignment: .leading,spacing: 4) {
                            Text(viewModel.name).foregroundColor(Color.orange)
                            Text(viewModel.label).foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date).foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth:300,alignment: .leading)
                        
                        Spacer()
                        
                        VStack (alignment: .leading,spacing:4) {
                            Text("Registrado")
                                .foregroundColor(Color.orange)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
        }.background {
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange,lineWidth: 1.4)
                .shadow(color:.gray,radius:1,x:1.0,y:1.0)
        }
        .padding(.vertical,4)
    }
}




#Preview{
    NavigationView {
        List{
            HabitCardView(viewModel: HabitCardViewModel(id: 1, icon: "https://placehold.co/400", date: "01/01/2025 00:00:00", label: "horas",value: "2", state:.green, name: "Tocar guitarra" ))
            
        }.frame(maxWidth: .infinity)
            .navigationTitle("Lista")
            .listStyle(.plain)
        
    }
    
}
