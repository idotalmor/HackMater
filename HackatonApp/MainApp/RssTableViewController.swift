import UIKit


class RssTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
 

    
    
    //MARK: - Table view data source
    var parser: XMLParser = XMLParser()
    var posts: [RssItem] = []
    var rssItem : RssItem = RssItem()
    var eName: String = String()
    var segueArticleLink : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegRE reference
        
        
        tableView.dataSource = self
        tableView.delegate = self
        let url:URL = URL(string: "https://rcs.mako.co.il/rss/home-family-toddlers.xml")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RssCell", for: indexPath) as! RssCell
        let item = posts[indexPath.row] as! RssItem
        cell.postTitle.text = item.Title
        cell.postDescription.text = item.Description
        cell.photoURL = item.Image
        
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueArticleLink = posts[indexPath.row].Link
        performSegue(withIdentifier: "RssToArticle", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? RssArticleViewController else {return}
        dest.articleURL = self.segueArticleLink
    }
}

extension RssTableViewController: XMLParserDelegate{
    
    
    // MARK: - NSXMLParserDelegate methods
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        
        eName = elementName
        if elementName == "item"
        {
            self.rssItem = RssItem()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        
        let data = string
        if (!data.isEmpty)
        {
            if eName == "title"
            {
                rssItem.Title += data
            }
            else if eName == "link"
            {
                rssItem.Link += data
            }
            else if eName == "image"
            {
                rssItem.Image += data
            }
            else if eName == "description"
            {                
                rssItem.Description += data
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item"
        {
            
            posts.append(rssItem)
            let index = IndexPath(row: posts.count, section: 0)
            tableView.insertRows(at: [index], with: .left)
            
        }
    }
    
 
    
}

