//done
import UIKit

class ManagerDeliveryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var transactions = [Transaction]()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    @IBAction func refreshPage(_ sender: UIBarButtonItem) {
        
        refresh()
        
    }
    @IBAction func segmentBtn(_ sender: UISegmentedControl) {
        refresh()
    }
    
    var json : Any = ""{
        didSet{
            
            guard let transaction = json as? [Json] else {return}
            for (idx ,tran) in transaction.enumerated() {
                guard let tran = tran as? Json else {return}
                
                DispatchQueue.main.async {
                    self.transactions.append(Transaction(json: tran))
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
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerDeliveryTableViewCell") as! ManagerDeliveryTableViewCell
        
        var transaction = transactions[indexPath.row]
        var product = Products().search(forBarcode: transaction.product)
        
        cell.imageProd.image = product?.prodImage
        if(transaction.status == "1"){
            cell.deliveryguyname.text = transaction.locationAdeliveryguy
            cell.locationProd.text = transaction.locationAString
            cell.dateProd.text = SecToDate(timeStamp: transaction.locationAtime)
        }else if(transaction.status == "4"){
            cell.deliveryguyname.text = transaction.locationBdeliveryguy
            cell.locationProd.text = transaction.locationBString
            cell.dateProd.text = SecToDate(timeStamp: transaction.locationBtime)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ManagerDeliveryToTransaction", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ManagerDeliveryProductViewController{
            dest.transaction = transactions[(tableview.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    func refresh(){
        transactions = []
        tableview.reloadData()
        if segment.selectedSegmentIndex == 0 //first
        {

            var parametersjson = ["status": "1","warehouse": User.current?.warehouse]
            getWaitingProducts(params: parametersjson)
            
            
        }else //second
        {
            var parametersjson = ["status": "4","warehouse": User.current?.warehouse]
            getWaitingProducts(params: parametersjson)
            
        }
    }
}

extension ManagerDeliveryViewController{
    
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
