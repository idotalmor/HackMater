import UIKit

class DeliveryWaitingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var transaction = [Transaction]()
    var parameters : [String:String] = [:]
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func refreshPage(_ sender: UIBarButtonItem) {
        refresh()
    }
    
    
    var json : Any = ""{
        didSet{
            
            guard let transaction = json as? [Json] else {return}
            for (idx ,tran) in transaction.enumerated() {
                guard let tran = tran as? Json else {return}
                
                DispatchQueue.main.async {
                    self.transaction.append(Transaction(json: tran))
                    let indexpath = IndexPath(row: idx, section: 0)
                    self.tableview.insertRows(at: [indexpath], with: .right)
                }
            }
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        refresh()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "deliveryWaitingCell") as!DeliveryWaitingTableViewCell
        
                var transactions = transaction[indexPath.row]
                guard let product = Products().search(forBarcode: transactions.product) else {return cell}
        
                cell.imageProduct.image = product.prodImage
                cell.nameProduct.text = product.prodName
        
                var time:String = ""
                if(transactions.status == "0"){
                    cell.loacationProduct.text = transactions.locationAString
                    time = transactions.locationAtime
        
                }else if(transactions.status == "3"){
                    cell.loacationProduct.text = transactions.locationBString
                    time = transactions.locationBtime

                }
        
                cell.status = Int(transactions.status)!
                cell.dateProduct.text = SecToDate(timeStamp: time)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "deliveryWaitingCell", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DeliveryWaitingProductViewController {
            dest.transaction = transaction[(tableview.indexPathForSelectedRow?.row)!]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.navigationController?.popToRootViewController(animated: true)
        refresh()
    }
    
    
    func refresh(){
        
        transaction = []
        parameters = ["locationAdeliveryguy": (User.current?.name)!]
        tableview.reloadData()
        getDeliveryTransaction()
        
        transaction = []
        parameters = ["locationBdeliveryguy": (User.current?.name)!]
        tableview.reloadData()
        getDeliveryTransaction()
        
    }
    
}


extension DeliveryWaitingViewController {
    
    func getDeliveryTransaction(){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/transactions/locationadeliveryguy") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    self.json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(self.json)
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()
    }
}
