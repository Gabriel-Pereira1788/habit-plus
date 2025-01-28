//
//  HabitViewModel.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 06/01/25.
//


import SwiftUI
import Foundation
import Combine

class HabitViewModel:ObservableObject {
    @Published var uiState:HabitUIState = .loading
    @Published var title = "Atenção"
    @Published var subhead = "Fique ligado!"
    @Published var desc = "Voce esta atrasado nos habitos."
    @Published var opened = false
    
    private let interactor:HabitInteractor
    private var cancellableRequest: AnyCancellable?
    
    init(interactor:HabitInteractor){
        self.interactor = interactor
        
    }
    
    deinit {
        cancellableRequest?.cancel()
    }
    
    func onAppear() {
        
        opened = true
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
            switch(completion) {
            case .failure(let appError):
                self.uiState = .error(appError.message)
                break
                
            case .finished:
                break
            }
        }) { response in
            if response.isEmpty {
                self.uiState = .emptyList
                self.title = ""
                self.subhead = "Fique ligado!"
                self.desc = "Voce ainda não possui hábitos"
            } else {
                
                
                self.uiState = .fullList(response.map {
                    let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                    let lastDateCompare = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "yyyy-MM-dd HH:mm") ?? ""
                    
                    var state = Color.green
                    self.title = "Muito bom!"
                    self.subhead = "Seus hábitos estão em dia"
                    self.desc = ""
                    
                    if lastDateCompare < Date().toString(destPattern: "yyyy-MM-dd HH:mm") {
                        state = .red
                        self.title = "Atenção"
                        self.subhead = "Fique ligado!"
                        self.desc = "Voce está atrasado nos hábitos"
                        
                    }
                    return HabitCardViewModel(id: $0.id,
                                              icon: $0.iconUrl ?? "",
                                              date: lastDate,
                                              label: $0.label,
                                              value: "\($0.value ?? 0)",
                                              state:state,
                                              name: $0.name)
                })
            }
        }
    }
    
}
