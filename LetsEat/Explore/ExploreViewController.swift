//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Guy  Boscawen on 23/06/2020.
//  Copyright © 2020 Guy  Boscawen. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let manager = ExploreDataManager()
    
    var selectedCity: LocationItem?
    var headerView: ExploreHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue {
            guard selectedCity != nil else {
                showAlert()
                return false
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
        case Segue.restaurantList.rawValue:
            showRestaurantListing(segue: segue)
        default:
            print("segue not added")
        }
    }
}

// MARK: Private Extension
private extension ExploreViewController {
    func initialize() {
        manager.fetch()
    }
    
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {}
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            if let location = selectedCity {
                headerView.lblLocation.text = location.full
            }
        }
    }
    
    func showLocationList(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? LocationViewController else {
            return
        }
        
        guard let city = selectedCity else {
            return
        }
        viewController.selectedCity = city
    }
    
    func showRestaurantListing(segue: UIStoryboardSegue) {
        if let viewContoller = segue.destination as? RestaurantListViewController, let city = selectedCity, let index = collectionView.indexPathsForSelectedItems?.first {
            viewContoller.selectedType = manager.explore(at: index).name
            viewContoller.selectedCity = city
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Location Needed", message: "Please select a location", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return manager.numberOfItems()
       }
       
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
       
       let item = manager.explore(at: indexPath)
       cell.lblName.text = item.name
       cell.imgExplore.image = UIImage(named: item.image)
       return cell
   }
       
   func collectionView(_ collectionView: UICollectionView,  viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        
       headerView = header as? ExploreHeaderView
       return headerView
   }
}
