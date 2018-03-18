
import Foundation
import UIKit
import FCAlertView


typealias Json = [String:Any]
extension UIViewController{
    func misAlert(Title:String,Message:String, image:UIImage){
        let alert = FCAlertView()
        alert.colorScheme = UIColor(red: 0/255, green: 79/255, blue: 150/255, alpha: 1)
        alert.dismissOnOutsideTouch = true
        alert.bounceAnimations = true
        alert.showAlert(inView: self,
                        withTitle: Title,                        withSubtitle: Message,
                        withCustomImage: image,
                        withDoneButtonTitle: nil,
                        andButtons: nil)
    }
    
    func SecToDate(timeStamp: String) -> String? {
        
        guard let time = Double(timeStamp) else{return nil}
        let date = Date(timeIntervalSince1970: (time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:Locale.current.identifier)
        dateFormatter.dateFormat = "dd/MM hh:mm"
        return dateFormatter.string(from: date)
    }
    
    func currentToSeconds() ->String{
        let today = String((Date().timeIntervalSince1970).rounded())
        return today
    }
    
    func stringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    

    
    
}

extension UITableViewCell{

    
    func SecToDate(timeStamp: String) -> String? {
        
        guard let time = Double(timeStamp) else{return nil}
        let date = Date(timeIntervalSince1970: (time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier:Locale.current.identifier)
        dateFormatter.dateFormat = "dd/MM hh:mm"
        return dateFormatter.string(from: date)
    }
    
    func currentToSeconds() ->String{
        let today = String((Date().timeIntervalSince1970).rounded())
        return today
    }
    

    
}
