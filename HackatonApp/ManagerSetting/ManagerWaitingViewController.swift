//done
import UIKit

class ManagerWaitingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var transactions = [Transaction]()
    
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBAction func refreshPage(_ sender: UIBarButtonItem) {
        
        reloadData()
    }
    

    var json : Any = ""{
        didSet{
            guard let transactionsArr = json as? [Json] else {return}
            
            for (idx ,tran) in transactionsArr.enumerated() {
                guard let tran = tran as? Json else {return}
                
                DispatchQueue.main.async {
                    self.transactions.append(Transaction(json: tran))
                    let indexpath = IndexPath(row: self.transactions.count-1, section: 0)
                    self.tableview.insertRows(at: [indexpath], with: .right)
                }
            }
        }}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        reloadData()

    }
    
    func reloadData(){
        
        transactions = []
        tableview.reloadData()
        var parametersjson = ["status": "0","warehouse": User.current?.warehouse]
        getWaitingProducts(params: parametersjson)
        parametersjson = ["status": "3","warehouse":  User.current?.warehouse]
        getWaitingProducts(params: parametersjson)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerWaitingCell") as! ManagerWaitingTableViewCell
        
        var transaction = transactions[indexPath.row]
        guard let product = Products().search(forBarcode: transaction.product) else {return cell}
        
        cell.imageProd.image = product.prodImage
        cell.nameprod.text = product.prodName
        
       var time:String = ""
        if(transaction.status == "0"){
            cell.locationProd.text = transaction.locationAString
            time = transaction.locationAtime

        }else if(transaction.status == "3"){
            cell.locationProd.text = transaction.locationBString
            time = transaction.locationBtime
        }

        cell.status = Int(transaction.status)!
        cell.dateProd.text = SecToDate(timeStamp: time)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ManagerWaitingToTransaction", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ManagerWaitingProductViewController{
            dest.transaction = transactions[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
}

extension ManagerWaitingViewController{
    
    func getWaitingProducts(params:Json){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/transactions/managereye") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject:params, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    self.json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}



