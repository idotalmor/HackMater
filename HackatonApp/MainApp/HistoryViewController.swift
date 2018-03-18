//done
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var transactions = [Transaction]()
    var parameters : [String:String] = [:]
    
    var image: String = ""
    var json : Any = ""{
        didSet{
            guard let transactionsArr = json as? [Json] else {return}
            DispatchQueue.main.async {
                switch self.segment.selectedSegmentIndex {
                case 1,2:
                    for (idx ,tran) in transactionsArr.enumerated() {
                        guard let tran = tran as? Json else {return}
                        
                        DispatchQueue.main.async {
                            self.transactions.append(Transaction(json: tran))
                            let indexpath = IndexPath(row: idx, section: 0)
                            self.tableview.insertRows(at: [indexpath], with: .right)
                        }
                    }
                default:
                    for (idx ,tran) in transactionsArr.enumerated() {
                        guard let tran = tran as? Json else {return}
                        
                        DispatchQueue.main.async {
                            self.transactions.append(Transaction(json: tran))
                            let indexpath = IndexPath(row: self.transactions.count-1, section: 0)
                            self.tableview.insertRows(at: [indexpath], with: .right)
                        }
                    }
                }
            }

        }
    }
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func segmentBtn(_ sender: UISegmentedControl) {
        
        reloadData()
    }
    
    @IBAction func refreshBtn(_ sender: UIButton) {
        reloadData()
    }
    
    func reloadData(){
        switch segment.selectedSegmentIndex {
        case 0:do {
            transactions = []
            tableview.reloadData()
            self.parameters = [
                "senderuid":(User.current?.id)!
            ]
            self.getHistory(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/senderinprogress")
            self.parameters = [
                "receiveruid":(User.current?.id)!
            ]
            self.getHistory(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/receiverinprogress")
            }
            
        case 1:do {
            transactions = []
            tableview.reloadData()
            self.parameters = [
                "senderuid":(User.current?.id)!
            ]
            self.getHistory(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/senderdone")
            }
        default:do {
            transactions = []
            tableview.reloadData()
            self.parameters = [
                "receiveruid":(User.current?.id)!
            ]
            self.getHistory(urlstr: "https://maternaApp.mybluemix.net/api/v1/transactions/receiverdone")
            }
            
            
        }}
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMainTableViewCell") as! HistoryTableViewCell
        
        cell.transaction = transactions[indexPath.row]
        
        //        if indexPath.row % 2 == 0 {
        //            cell.contentView.backgroundColor = UIColor.red
        //
        //        }else{
        //            cell.contentView.backgroundColor = UIColor.white
        //
        //        }
        
        return cell
    }
    
}

extension HistoryViewController {
    
    func getHistory (urlstr:String){
        guard let url = URL(string: urlstr) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
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
