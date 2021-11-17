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
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let jsonDecoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: "Cakes", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            cakes = try jsonDecoder.decode([Cake].self, from: data)
            //print(cakes)
            //print(data)
        } catch {
            print(error.localizedDescription)
        }
        getCakes()
        
    }
    
    func getCakes() {
        let urlSession = URLSession.shared
        guard let url = URL(string: "https://gist.githubusercontent.com/hart88/79a65d27f52cbb74db7df1d200c4212b/raw/ebf57198c7490e42581508f4f40da88b16d784ba/cakeList") else {
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in
            let decoder = JSONDecoder()
            
            guard let _data = data else {
                return
            }
            
            do {
                let cakes = try decoder.decode([Cake].self, from: _data)
                print(cakes)
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
        dataTask.resume()
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

