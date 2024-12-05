import Foundation
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
    private var interactor: SignUpInteractor
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    init(interactor:SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
    
    func singUp() {
        uiState = .loading
        let date = formatDate(date: form[.birthdate]!)
        let signUpData = SignUpRequest(
            fullname: form[.fullname] ?? "",
            email: form[.email] ?? "",
            password: form[.password] ?? "",
            document: form[.document] ?? "",
            phone: form[.phone] ?? "",
            gender: gender.index,
            birthDate: date ?? "")
        
        cancellableSignUp = interactor.signup(signUpRequest: signUpData)
            .receive(on: DispatchQueue.main )
            .sink { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(msg: appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                if(created) {
                    self.onSignIn()
                }
            }
        
    }
    
    func setRouterPublisher(_ toPubilsher: PassthroughSubject<AuthRouterUIState,Never>) {
        routerPublisher = toPubilsher
    }
    
    
}

extension SignUpViewModel {
    func onSignIn() {
        self.cancellableSignIn = self.interactor.signIn(signInRequest: SignInRequest(email: self.form[.email]!, password: self.form[.password]!))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let appError):
                    self.uiState = .error(msg: appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.routerPublisher.send(.goToHomeView)
                self.uiState = .success
            }
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
    
    func formatDate(date:String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from:date)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error(msg: "Data invalida \(date)")
            return nil
        }
        
        formatter .dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: dateFormatted)
    }
}

