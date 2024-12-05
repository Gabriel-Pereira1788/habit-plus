struct SignUpRequest:Encodable {
    let fullname:String
    let email:String
    let password:String
    let document:String
    let phone:String
    let gender:Int
    let birthDate:String
    
    enum CodingKeys:String, CodingKey {
        case fullname = "name"
        case email
        case password
        case document
        case phone
        case gender
        case birthDate = "birthday"
    }
}
