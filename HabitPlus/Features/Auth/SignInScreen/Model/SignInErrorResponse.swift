
struct SignInErrorResponse: Decodable {
    let detail: SignInDetailsErrorResponse?
    
    enum CodingKeys:String, CodingKey {
       case detail
    }
}



struct SignInDetailsErrorResponse: Decodable {
    let message: String?
    
    enum CodingKeys:String, CodingKey {
       case message
    }
}
