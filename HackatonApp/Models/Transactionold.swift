
import Foundation
import UIKit

class Transactionold:Decodable {
    
    
    var status: Int?
    var locationA: Double
    var warehouse: String
    var locationB: Double
    var todeliveryguy: String
    var fromdeliveryguy: String
    var product: String
    var warehouseguy: String
  
    init(json:[String: Any])  {
        
        status = Int(json["status"] as! String)
        locationA = json["locationA"] as! Double
        warehouse = json["warehouse"] as! String
        locationB = json["locationB"] as! Double
        todeliveryguy = json["todeliveryguy"] as! String
        fromdeliveryguy = json["fromdeliveryguy"] as! String
        product = json["product"] as! String
        warehouseguy = json["warehouseguy"] as! String
        
        
        
    }

}


