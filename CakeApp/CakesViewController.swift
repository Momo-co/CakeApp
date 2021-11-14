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
        return cell
    }
    
}

extension CakesViewController: UICollectionViewDelegate {
    
}

extension CakesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 200.0)
    }
    
}

