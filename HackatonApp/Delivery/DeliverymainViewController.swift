import UIKit


class DeliverymainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var transactions = [Transaction]()
    var product : ProductID?
    
    var parameters : [String:String] = [:]

    @IBOutlet weak var tableView: UITableView!
    @IBAction func refreshpage(_ sender: UIBarButtonItem) {
        
        transactions = []
        tableView.reloadData()
        getDeliveryTransaction()
    }
    
    var json : Any = ""{
        didSet{
            guard let transactionsArr = json as? [Json] else {return}
            
            for (idx ,tran) in transactionsArr.enumerated() {
                guard let tran = tran as? Json else {return}
                
                DispatchQueue.main.async {
                    self.transactions.append(Transaction(json: tran))
                    let indexpath = IndexPath(row: self.transactions.count-1, section: 0)
                    self.tableView.insertRows(at: [indexpath], with: .right)
                }
            }
        }}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDeliveryTransaction()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell") as! DeliveryTableViewCell
        
        
        var transaction = transactions[indexPath.row]
        guard let product = Products().search(forBarcode: transaction.product) else {return cell}

        cell.imageLabel.image = product.prodImage
        cell.nameLabel.text = product.prodName
        
        var time:String = ""
        if(transaction.status == "0"){
            cell.locationLabel.text = transaction.locationAString
            time = transaction.locationAtime

        }else if(transaction.status == "3"){
            cell.locationLabel.text = transaction.locationBString
            time = transaction.locationBtime
        }

        cell.status = Int(transaction.status)!
        cell.dateLabel.text = SecToDate(timeStamp: time)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showProductDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DeliveryConfirmViewController {
            dest.transaction = transactions[(tableView.indexPathForSelectedRow?.row)!]
        
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // self.navigationController?.popToRootViewController(animated: true)
        transactions = []
        tableView.reloadData()
        getDeliveryTransaction()
    }
    
}


extension DeliverymainViewController {
    
    func getDeliveryTransaction(){
        guard let url = URL(string: "https://maternaApp.mybluemix.net/api/v1/transactions/waitingfordelivery") else { return }
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

