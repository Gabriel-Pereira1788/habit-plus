import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var uiState: SignUpUIState = .none
    @Published var gender:Gender = .male
    @Published var form:[KeySignUpForm:String] = [
        .fullname:"",
        .password:"",
        .email:"",
        .document:"",
        .phone:"",
        .birthdate:"",
    ]
    
    private var routerPublisher: PassthroughSubject<AuthRouterUIState,Never>!
    
    
    func singUp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.uiState = .success
            self.routerPublisher.send(AuthRouterUIState.goToHomeView)
        }
    }
    
    func setRouterPublisher(_ toPubilsher: PassthroughSubject<AuthRouterUIState,Never>) {
        routerPublisher = toPubilsher
    }
    
    
}

extension SignUpViewModel {
    
    func goToHomeScreen() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}


extension SignUpViewModel {
    func getFormValue(key:KeySignUpForm) -> Binding<String> {
        
        return Binding(
            get: {self.form[key] ?? ""},
            set:{self.form[key] = $0}
        )
    }
    
    func validateField(key: KeySignUpForm) -> Bool {
        switch (key) {
        case .email:
            return form[.email]!.isEmail()
        case .password:
            return form[.password]!.count > 3
        case .birthdate:
            return form[.birthdate]!.count == 10
        case .document:
            return form[.document]!.count == 11
        case .phone:
            return form[.phone]!.count > 10 && form[.phone]!.count <= 12
        case .fullname:
            return form[.fullname]!.count > 3
        }
    }
    
    func isDisabled() -> Bool {
        return KeySignUpForm.allCases.contains(where: {!validateField(key: $0)})
    }
}

