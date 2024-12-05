//
//  LocalDataSource.swift
//  HabitPlus
//
//  Created by Gabriel Pereira on 05/12/24.
//
import Foundation
import Combine

class LocalDataSource {
        
    static var shared = LocalDataSource()
    
    private init() {
        
    }
    func saveValue<T:Codable>(key:String,value:T) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value),forKey:key)
    }
    
    func readValue<T:Codable>(forKey key:String) -> T? {
        var data: T?
        if let dataSource = UserDefaults.standard.value(forKey: key) as? Data {
            data = try? PropertyListDecoder().decode(T.self, from: dataSource)
        }
        return data
    }
}
