
import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate

    var data = [Transactionold]()
    var productsegmentone = [Transactionold]()
    var productsegmenttwo = [Transactionold]()
    var productsegmentthree = [Transactionold]()
    var products :[ProductID]?

    
    var image: String = ""

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func segmentBtn(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 //first
        {
            data = productsegmentone
            
        }else if (sender.selectedSegmentIndex == 1) //second
        {
            data = productsegmenttwo
        }else{
           // sender.selectedSegmentIndex == 2//three
        }
        
        self.tableview.reloadData()
    }
    
    var json :Json = ["status":"0","locationA":3.22,"warehouse":"3333","locationB":34.654,"todeliveryguy":"654654","fromdeliveryguy":"deliveryguyuid","product":"productid","warehouseguy":"warehouseguyuid"]
    var jsontwo :Json = ["status":"0","locationA":3.22,"warehouse":"55555","locationB":34.654,"todeliveryguy":"654654","fromdeliveryguy":"deliffffveryguyuid","product":"productid","warehouseguy":"warehouseguyuid"]
    var jsonthree :Json = ["status":"0","locationA":3.22,"warehouse":"44444","locationB":34.654,"todeliveryguy":"654654","fromdeliveryguy":"deliffffveryguyuid","product":"productid","warehouseguy":"warehouseguyuid"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        products = Products().products

        tableview.delegate = self
        tableview.dataSource = self
        productsegmentone.append(Transactionold(json: json))
        productsegmenttwo.append(Transactionold(json: jsontwo))
        productsegmentthree.append(Transactionold(json: jsonthree))

        data = productsegmentone
        tableview.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMainTableViewCell") as! HistoryTableViewCell
        
        cell.nameProdLabel.text = data[indexPath.row].fromdeliveryguy
        cell.dateProdLabel.text = data[indexPath.row].fromdeliveryguy
        cell.imageviewProd.image = UIImage(named: "advenced-3") ///// products![indexPath.row].prodImage

        
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.red
            
        }else{
            cell.contentView.backgroundColor = UIColor.white
            
        }
        
        return cell
    }
    




}
