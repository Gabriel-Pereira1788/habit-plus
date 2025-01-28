//
//  AuthDataSource.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 03/12/24.
//
import Foundation
import Combine
class AuthDataSource {
    
    static var shared = AuthDataSource()
    private init() {
        
    }
    
    func createUser(request:SignUpRequest) -> Future<Bool,AppError> {
        return Future { promise in
            WebService.call(method: .post, endPoint: .users, body: request) {result in
                switch result {
                case .success(_):
                    promise(.success(true))
                    break
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            print(data)
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor.")))
                        }
                    }
                    
                    promise(.failure(AppError.response(message: "Erro desconhecido no servidor.")))
                    
                    break
                }
                
            }
        }
    }
    
    func login(request:SignInRequest) -> Future<SignInResponse, AppError>{
        
        return Future<SignInResponse, AppError> { promise in
            
            WebService.call(method: .post, endPoint: .login, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name:"password",value: request.password)
            ]) { result in
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    
                    guard let response = response else {
                        print("Error de parser \(String(data:data,encoding: .utf8))")
                        return
                    }
                    
                    promise(.success(response))
                    break
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            print(data)
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            
                            promise(.failure(AppError.response(message: response?.detail?.message ?? "Erro desconhecido no servidor.")))
                        }
                    }
                    promise(.failure(AppError.response(message: "Erro desconhecido no servidor.")))
                    break
                }
            }
        }
        
    }
}
