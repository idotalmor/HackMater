import UIKit

struct Products{
    var products: [ProductID]

    init(items: [ProductID]? = nil){
        
        guard items == nil else {
            self.products = items ?? []
            return
        }
        products = [
        ProductID(prodName: "1 אקסטרה קאר שלב 1", experationDate: "" , prodDetails: "שמן בטאפלמיטט המוכח מחקרית כתורם לעיכול קל ולהפחתת משך בכי בתינוקות", prodImage: UIImage(named: "extraCare1")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extracare/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extra-care-%D7%A9%D7%9C%D7%911", barcode: "7290013083661"),
        ProductID(prodName: "2 אקסטרה קאר שלב 2", experationDate: "" , prodDetails: "פרה ביוטיקה - סיבים פרה ביוטים מסוג GOS התורמים לפעילות מיטבית של החיידקים הפרוביוטיים", prodImage: UIImage(named: "ExtraCare2")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extracare/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extra-care-%D7%A9%D7%9C%D7%912" , barcode: "7290013083678"),
        ProductID(prodName: "3 אקסטרה קאר שלב 3", experationDate: "" , prodDetails: "פרוביוטיקה מסוג B.lactis חיידקים ידידותיים למערכת עיכול", prodImage: UIImage(named: "ExtraCare3")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extracare/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extra-care-%D7%A9%D7%9C%D7%913", barcode: "7290013083685"),
        ProductID(prodName: "חלבי שלב 1", experationDate: "" , prodDetails: "שמן בטאפלמיטט המוכח מחקרית כתורם לעיכול קל ולהפחתת משך בכי בתינוקות", prodImage: UIImage(named: "advenced-1")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%AA%D7%9E%D7%9C-%D7%97%D7%9C%D7%91%D7%99-%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%97%D7%9C%D7%91%D7%99-%D7%A9%D7%9C%D7%91-1", barcode: "72900011447267"),
        ProductID(prodName: "חלבי שלב 2", experationDate: "" , prodDetails: "הרכב חלבון מתקדם – יחס אלבומין/קזאין 40:60 עד גיל שנה", prodImage: UIImage(named: "advenced-2")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%AA%D7%9E%D7%9C-%D7%97%D7%9C%D7%91%D7%99-%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%97%D7%9C%D7%91%D7%99-%D7%A9%D7%9C%D7%91-2", barcode: "72900011447281"),
        ProductID(prodName: "חלבי שלב 3", experationDate: "" , prodDetails: "מטרנה חלבי שלב 3 מיוצר בישראל, בפיקוח ישיר ומתמיד של צוות מדענים ומדעניות שבריאות תינוקך חשובה להם יותר מכל.", prodImage: UIImage(named: "advenced-3")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%AA%D7%9E%D7%9C-%D7%97%D7%9C%D7%91%D7%99-%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%97%D7%9C%D7%91%D7%99-%D7%A9%D7%9C%D7%91-3", barcode: "72900011447304"),
        ProductID(prodName: "מהדרין שלב 1", experationDate: "" , prodDetails: "הרכב חלבון מתקדם – יחס אלבומין/קזאין 40:60 עד גיל שנה", prodImage: UIImage(named: "Mehadrin-Chalavi1")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D-%D7%9C%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F/%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F-%D7%A9%D7%9C%D7%91-1", barcode: "72900011447359"),
        ProductID(prodName: "מהדרין שלב 2", experationDate: "" , prodDetails: "אבץ, סלניום וויטמינים מסוג C,E - אנטיאוקסידנטים ונוקליאוטידים.", prodImage: UIImage(named: "Mehadrin-Chalavi2")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D-%D7%9C%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F/%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F-%D7%A9%D7%9C%D7%91-2", barcode: "72900011447373" ),
        ProductID(prodName: "מהדרין שלב 3", experationDate: "" , prodDetails: "הרכב ייחודי של מינרלים כגון ברזל וסידן", prodImage: UIImage(named: "Mehadrin-Chalavi3")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%94%D7%94%D7%A8%D7%9B%D7%91-%D7%94%D7%9E%D7%AA%D7%A7%D7%93%D7%9D-%D7%9C%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F/%D7%9E%D7%94%D7%93%D7%A8%D7%99%D7%9F-%D7%A9%D7%9C%D7%91-3", barcode: "7290008975551"),
        ProductID(prodName: "צמחי מגיל לידה עד גיל שנה", experationDate: "" , prodDetails: "אבץ, סלניום וויטמינים מסוג E,C - אנטיאוקסידנטים", prodImage: UIImage(named: "VegMatrna0")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%94%D7%A1%D7%93%D7%A8%D7%94-%D7%94%D7%A6%D7%9E%D7%97%D7%99%D7%AA/%D7%A6%D7%9E%D7%97%D7%99-%D7%9E%D7%92%D7%99%D7%9C-%D7%9C%D7%99%D7%93%D7%94-%D7%A2%D7%93-%D7%92%D7%99%D7%9C-%D7%A9%D7%A0%D7%94", barcode: "7290014258723"),
        ProductID(prodName: "צמחי מגיל שנה ואילך", experationDate: "" , prodDetails: "מטרנה צמחי מגיל שנה ואילך מיוצר בישראל, בפיקוח ישיר ומתמיד של צוות מדענים ומדעניות שבריאות תינוקך חשובה להם יותר מכל", prodImage: UIImage(named: "VegMatrna1")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%94%D7%A1%D7%93%D7%A8%D7%94-%D7%94%D7%A6%D7%9E%D7%97%D7%99%D7%AA/%D7%A6%D7%9E%D7%97%D7%99-%D7%9E%D7%92%D7%99%D7%9C-%D7%A9%D7%A0%D7%94-%D7%95%D7%90%D7%99%D7%9C%D7%9A", barcode: "7290014258730"),
        ProductID(prodName: "סנסטיב לפגים", experationDate: "" , prodDetails: "שמן בטאפלמיטט שהוכח במחקרים כתורם לעיכול קל והפחתת בכי בתינוקות", prodImage: UIImage(named: "ExtraCareSensitive")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%A1%D7%A0%D7%A1%D7%98%D7%99%D7%91-%D7%A4%D7%92%D7%99%D7%9D", barcode: "7290008975155"),
        ProductID(prodName: "אקסטרה קאר קומפורט", experationDate: "" , prodDetails: "פרוביוטיקה מסוג לקטובצילוס ראוטרי, הקיימת באופן טבעי במעי של תינוקות יונקים,  שהוכחה מחקרית כמקלה על העיכול ומפחיתה משך בכי בתינוקות עם קוליק.", prodImage: UIImage(named: "ExtraCareComfort")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-extracare-comfort", barcode: "7290014258914"),
        ProductID(prodName: "מטרנה לילה טוב", experationDate: "" , prodDetails: "מומלץ כבקבוק לפני השינה - מכיל הרכב ייחודי של פחמימות מורכבות לארוחה שלפני השינה.", prodImage: UIImage(named: "goodnightMaterna")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%9C%D7%99%D7%9C%D7%94-%D7%98%D7%95%D7%91", barcode: "7290013591173"),
        ProductID(prodName: "מטרנה .Extra Care A.R לתינוקות פולטים", experationDate: "" , prodDetails: "הרכב שמנים ייחודי מסוג בטאפלמיטט התורם למרקם יציאות רך, להפחתת משך בכי בתינוקות ולעידוד צמיחת הפרוביוטיקה במעי", prodImage: UIImage(named: "ExtraCareAR")!, prodLink: "https://www.materna.co.il/%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D/%D7%AA%D7%97%D7%9C%D7%99%D7%A4%D7%99-%D7%97%D7%9C%D7%91/%D7%9E%D7%98%D7%A8%D7%A0%D7%94-%D7%90%D7%A7%D7%A1%D7%98%D7%A8%D7%94-%D7%A7%D7%A8-a-r", barcode: "7290014258921"),
        ]
        
    }
    
    mutating func append(product: ProductID) {
        products.append(product)
    }
    
    func search(forBarcode barcode: String) -> ProductID? {
        return products.filter({ $0.barcode == barcode }).first
    }
//    func getimageProd (forImage prodImage: String) -> ProductID? {
//        return products.filter({ $0.prodImage == prodImage })
//    }
}

struct ProductID {
    var prodName: String
    var experationDate: String
    var prodDetails: String
    var prodImage:UIImage?
    var prodLink:String
    var barcode: String
    
    init(prodName: String, experationDate: String, prodDetails: String, prodImage: UIImage?, prodLink: String, barcode: String) {
        self.prodName = prodName
        self.experationDate = experationDate
        self.prodDetails = prodDetails
        self.prodImage = prodImage
        self.prodLink = prodLink
        self.barcode = barcode
    }
}
