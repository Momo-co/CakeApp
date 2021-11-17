//
//  ViewController.swift
//  CakeApp
//
//  Created by Suman Gurung on 14/11/2021.
//

import UIKit

class CakesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var cakes:[Cake] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("This will get printed before async/sync threads. Doesn't matter wheather the concurrent queue are in sync or async.")
        
        let sq = DispatchQueue(label: ".com.it.mac.Concurrency", attributes: .concurrent)
        
        sq.async {
            print("This may get executed in any order.1")
        }
        sq.async {
            print("This may get executed in any order.2")
        }
        sq.async {
            print("This may get executed in any order.3")
        }
        print("This will print before the async/sync threads. Doesn't matter wheather the concurrent queue are in sync or async.")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let jsonDecoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "Cakes", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            cakes = try jsonDecoder.decode([Cake].self, from: data)
            print(cakes)
            print(data)
        } catch {
            print(error.localizedDescription)
        }
        
    }

}

extension CakesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cakes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CakeCollectionViewCell
        
        cell.titleLabel.text = cakes[indexPath.row].title
        cell.descLabel.text = cakes[indexPath.row].desc
        
        return cell
    }
    
}

extension CakesViewController: UICollectionViewDelegate {
    
}

extension CakesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        let itemsPerRow:CGFloat = 2.0
        
        let padding = insets.left * (itemsPerRow + 1)
        
        let availableWidth = view.frame.width - padding
        
        return CGSize(width: availableWidth/itemsPerRow, height: availableWidth/itemsPerRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let insets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        return insets
    }
    
}

func randomFunction() {
    DispatchQueue.global().async {
        print("I am in global queue. This do not mean I am in main thread. Since I am not in main thread, the user interface(UI) of the app will keep running no matter how long or large this computation is.")
        DispatchQueue.main.async {
            print("This is the main thread/queue. You can use UI component related code in this thread.")
        }
    }
}
