
import Foundation

class Users: Codable {
    let users: [User]
    
    init(users: [User]) {
        self.users = users
    }
}


class User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, phonenumber, name, partneruid, mail, permission, warehouse
    }
    
    var id: String
    var permission: String
    var phonenumber: String
    var name: String
    var partneruid: String
    var mail: String
    var warehouse: String?
    

        init(json:Json) {
    
            id = json["id"] as! String
            permission = json["permission"] as! String
            phonenumber = json["phonenumber"] as! String
            name = json["name"] as! String
            partneruid = json["partneruid"] as! String
            mail = json["mail"] as! String
            warehouse = json["warehouse"] as? String

    
        }
    
//    init?(phonenumber: String?, password: String?) {
//        guard let phonenumber = phonenumber, let password = password else { return nil }
//        self.phonenumber = phonenumber
//        self.Password = password
//    }
    func save() {
        UserDefaults.standard.set(id, forKey: "id")
        UserDefaults.standard.set(permission, forKey: "permission")
        UserDefaults.standard.set(phonenumber, forKey: "phonenumber")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(partneruid, forKey: "partneruid")
        UserDefaults.standard.set(mail, forKey: "mail")
        UserDefaults.standard.set(warehouse, forKey: "warehouse")
        print("Save data UserDefaults")


    }
  static func remove() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "permission")
        UserDefaults.standard.removeObject(forKey: "phonenumber")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "partneruid")
        UserDefaults.standard.removeObject(forKey: "mail")
        UserDefaults.standard.removeObject(forKey: "warehouse")
        
    }
    
    
    static var current: User? {
        guard let id = UserDefaults.standard.value(forKey: "id") as? String,
        let permission = UserDefaults.standard.value(forKey: "permission") as? String,
        let phonenumber = UserDefaults.standard.value(forKey: "phonenumber") as? String,
        let name = UserDefaults.standard.value(forKey: "name") as? String,
        let partneruid = UserDefaults.standard.value(forKey: "partneruid") as? String,
        let mail = UserDefaults.standard.value(forKey: "mail") as? String else{return nil}
 
        
         let warehouse = UserDefaults.standard.value(forKey: "warehouse") as? String

        
        let json :Json = ["id": id, "permission": permission, "phonenumber": phonenumber, "name": name, "partneruid": partneruid, "mail": mail, "warehouse": warehouse]
        return User(json: json)
    }
}

