import Foundation


enum EndPoint: String {
    case base = "https://habitplus-api.tiagoaguiar.co"
    case users = "/users"
    case login = "/auth/login"
    case refreshToken = "/auth/refresh-token"
    case habits = "/users/me/habits"
}

enum Result {
    case success(Data)
    case failure(NetworkError,Data?)
}

enum NetworkError {
    case badRequest
    case notFound
    case unauthorized
    case internalServerError
}

enum HttpMethod:String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

enum ContentType:String {
    case json = "application/json"
    case formUrl = "application/x-www-form-urlencoded"
}

class WebService {
    
    static func getUrlRequest(endPoint:EndPoint) -> URLRequest? {
        guard let url = URL(string:"\(EndPoint.base.rawValue)\(endPoint.rawValue)") else {
            return nil
        }
        return URLRequest(url:url)
    }
    
    static  func call(method:HttpMethod,contentType:ContentType,urlRequest:URLRequest?,body:Data?, completion:@escaping (Result) -> Void) {
        
        guard var urlRequest = urlRequest else {return}
        
        let userAuthCancellable = AuthLocalDataSource.shared.getUserAuth().sink {userAuth in
            if let userAuth {
                urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
            }
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "accept")
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            
            if let body = body {
                urlRequest.httpBody = body
            }
            
            
            
            let task = URLSession.shared.dataTask(with: urlRequest) {data,response,error in
                
                guard let data = data, error == nil else {
                    
                    completion(.failure(.internalServerError, nil))
                    return
                }
                
                if let res = response as? HTTPURLResponse {
                    switch res.statusCode {
                    case 400:
                        completion(.failure(.badRequest, data))
                        break
                    case 401:
                        completion(.failure(.unauthorized, data))
                        break
                    case 200:
                        completion(.success(data))
                        break
                    default:
                        break
                    }
                }
            }
            
            task.resume()
        }
        
        
    }
    
    static func call(method:HttpMethod,endPoint:EndPoint, completion:@escaping (Result) -> Void){
        
        
        guard let urlRequest = getUrlRequest(endPoint: endPoint) else {return}
        call(method: method,contentType: .json, urlRequest: urlRequest, body: nil, completion: completion)
        
    }
    
    static func call<T:Encodable>(method:HttpMethod,endPoint:EndPoint,body:T, completion:@escaping (Result) -> Void){
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
        
        guard let urlRequest = getUrlRequest(endPoint: endPoint) else {return}
        call(method: method,contentType: .json, urlRequest: urlRequest, body: jsonData, completion: completion)
        
    }
    
    static func call(method:HttpMethod,endPoint:EndPoint,params:[URLQueryItem], completion:@escaping (Result) -> Void){
        guard let urlRequest = getUrlRequest(endPoint: endPoint) else {return}
        guard let absoluteUrl = urlRequest.url?.absoluteString else {return}
        
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
        
        call(method: method,contentType: .formUrl ,urlRequest: urlRequest, body: components?.query?.data(using: .utf8), completion: completion)
        
    }
    
}

extension WebService {
    
    static func post<T: Encodable,E:Decodable>(endPoint:EndPoint,body:T,completion: @escaping (Bool?, E?) -> Void) {
        call(method: .post, endPoint: endPoint, body: body) {response in
            switch response {
            case .success(let data):
                
                completion(true,nil)
                break
            case .failure(let error, let data):
                if let data = data {
                    if error == .badRequest {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(E.self, from: data)
                        completion(nil,response)
                        
                    }
                }
                break
            }
        }
    }
    
    static func post<T:Decodable,E:Decodable>(endPoint:EndPoint,params:[URLQueryItem],completion: @escaping (T?, E?) -> Void) {
        call(method: .post, endPoint: endPoint, params: params) {response in
            switch response {
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(T.self, from: data)
                completion(response,nil)
                break
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized {
                        let decoder = JSONDecoder()
                        print(data)
                        let response = try? decoder.decode(E.self, from: data)
                        completion(nil,response)
                        
                    }
                }
                break
            }
        }
    }
}

