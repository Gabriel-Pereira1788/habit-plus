import SwiftUI

struct HabitDetailsView:View {
    @ObservedObject var viewModel:HabitDetailsViewModel
    var body: some View {
        ScrollView(showsIndicators:false){
            VStack(alignment: .center,spacing: 12) {
                Text(viewModel.name)
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                Text("Unidade: \(viewModel.label)\n")
            }
            VStack {
                TextField("Escreva aqui o valor conquistado", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.numberPad)
                
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
            }
            
            Text("Os registros devem ser feitos em até 23h. \n Hábitos se constroem todos os dias")
            LoadingButtonView(action:{
                
            },disabled: self.viewModel.value.isEmpty,
                              showProgress: self.viewModel.uiState == .loading, text:"Salvar")
            .padding(.horizontal,16)
            .padding(.vertical,8)
            
            Button("Cancelar") {
                
            }.padding(.vertical,8)
            Spacer()
        }.padding(.horizontal,32)
        .padding(.top,32)
    }
}

#Preview {
    HabitDetailsView(viewModel: HabitDetailsViewModel(id: 1, name: "Academia", label: "Teste"))
}
