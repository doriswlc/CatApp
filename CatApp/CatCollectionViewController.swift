//
//  CatCollectionViewController.swift
//  CatApp
//
//  Created by doriswlc on 2022/9/19.
//

import UIKit
import Kingfisher
private let reuseIdentifier = "CatCollectionViewCell"

class CatCollectionViewController: UICollectionViewController {
    var cats: [Cat] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var request = URLRequest(url: URL(string: "https://api.thecatapi.com/v1/Favourites")!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3)
        request.setValue("DEMO-API-KEY", forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data, let response = response as? HTTPURLResponse, response.statusCode == 200, error == nil {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let catResponse = try decoder.decode([Cat].self, from: data)

                    DispatchQueue.main.async {
                        self.cats = catResponse
                        self.collectionView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return cats.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CatCollectionViewCell
        if indexPath.item.isMultiple(of: 3) {
            cell.catImageView.image = UIImage(named: "peter")
        } else {
            let cat = cats[indexPath.item]
            cell.catImageView.kf.setImage(with: cat.image.url)
        }
       
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
