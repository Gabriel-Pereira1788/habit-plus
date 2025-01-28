//
//  RouterRemoteDataSource.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 17/12/24.
//
import Foundation
import Combine

class RouterRemoteDataSource {
    static var shared = RouterRemoteDataSource()
    
    func refreshToken(request:RefreshRequest) -> Future<SignInResponse, AppError>{
        
        return Future<SignInResponse, AppError> { promise in
            
            WebService.call(method: .put, endPoint: .refreshToken, body: request) { result in
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
                    break
                }
            }
        }
        
    }
}
