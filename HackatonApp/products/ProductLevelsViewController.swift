
import UIKit

class ProductLevelsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource
{
    var products :[ProductID]?
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = Products().products
        collectionview.dataSource = self
        collectionview.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products!.count
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath)as! ProductMainCollectionViewCell
        
        let product = products![indexPath.row]
        cell.getTypeProd.image = product.prodImage
        cell.getTypeLabel.text = product.prodName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "allProd", sender: self)

        
        var productSegue = products![indexPath.row].prodImage
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? ProductLevelsSecViewController else {return}
        dest.product = self.products?[collectionview.indexPathsForSelectedItems![0].row]
        
    }
    
}
