
//
//  AuthDataSource.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 03/12/24.
//
import Foundation
import Combine
class HabitRemoteDataSource {
    
    static var shared = HabitRemoteDataSource()
    private init() {
        
    }
    
    func fetchHabits() -> Future<[HabitResponse],AppError> {
        return Future { promise in
            WebService.call(method: .get, endPoint: .habits) {result in
                switch result {
                case .success(let data):
                    //                    promise(.success(true))
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([HabitResponse].self, from: data)
                    
                    guard let response  = response else {
                        print("Log: Error parse \(String(data:data,encoding:.utf8)!)")
                        return
                    }
                    
                    promise(.success(response))
                    break
                case .failure(let error, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                        print(data)
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        
                        promise(.failure(AppError.response(message: response?.detail ?? "Erro desconhecido no servidor.")))
                        
                    }
                    break
                }
                
            }
        }
    }
}
