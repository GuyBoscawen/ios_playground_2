//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 23/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var manager = RestaurantDataManager()
    
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedType: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        createData()
        setupTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("selected city \(selectedCity as Any)")
        print("selected type \(selectedType as Any)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
                showRestaurantDetail(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
}

// MARK: Private Extension
private extension RestaurantListViewController {
    
    func createData() {
        guard let location = selectedCity?.city, let filter = selectedType else {
            return
        }
        
        manager.fetch(by: location, with: filter) {_ in
            if manager.numberOfItems() > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Restaurants")
                view.set(desc: "No Restaurants Found.")
                collectionView.backgroundView = view
            }
            collectionView.reloadData()
        }
    }
    
    func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let city = selectedCity?.city, let state = selectedCity?.state {
            title = "\(city.uppercased()), \(state.uppercased())"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            selectedRestaurant = manager.restaurantItem(at: index)
            viewController.selectedRestaurant = selectedRestaurant
        }
    }
}

// MARK UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell

        let item = manager.restaurantItem(at: indexPath)
        if let name = item.name {
            cell.lblTitle.text = name
        }
        if let cuisine = item.subtitle {
            cell.lblCuisine.text = cuisine
        }
        if let image = item.imageURL {
            if let url = URL(string: image) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.imgRestaurant.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }
}
