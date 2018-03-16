

import Foundation
import UIKit

class Transaction:Decodable {
    
var id : String
var status: String
var locationA: String
var locationAString: String
var locationAtime: String
var warehouse: String
var locationB: String
var locationBString: String
var locationBtime: String
var locationAdeliveryguy: String
var locationBdeliveryguy: String
var product: String
var expirationdate: String
var warehouseguy: String
var senderuid: String
var senderphonenumber: String
var sendername: String
var receiveruid: String
var receiverphonenumber: String
var receivername: String

init(json:[String: Any])  {
    
    id = json["id"] as! String
    status = json["status"] as! String
    locationA = json["locationA"] as! String
    locationAString = json["locationAString"] as! String
    locationAtime = json["locationAtime"] as! String
    warehouse = json["warehouse"] as! String
    locationB = json["locationB"] as! String
    locationBString = json["locationBString"] as! String
    locationBtime = json["locationBtime"] as! String
    locationAdeliveryguy = json["locationAdeliveryguy"] as! String
    locationBdeliveryguy = json["locationBdeliveryguy"] as! String
    product = json["product"] as! String
    expirationdate = json["expirationdate"] as! String
    warehouseguy = json["warehouseguy"] as! String
    senderuid = json["senderuid"] as! String
    senderphonenumber = json["senderphonenumber"] as! String
    sendername = json["sendername"] as! String
    receiveruid = json["receiveruid"] as! String
    receiverphonenumber = json["receiverphonenumber"] as! String
    receivername = json["receivername"] as! String
 
    }}


