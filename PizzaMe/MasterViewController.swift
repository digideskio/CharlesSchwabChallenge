//
//  MasterViewController.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit
//import QuartzCore

// MARK: - MasterViewController

class MasterViewController: UITableViewController {

    // MARK: - Property Delcarations
    
    private var detailViewController: DetailTableViewController? = nil
    fileprivate var viewModel:        RestaurantListViewModel?
    
    @IBOutlet var pizzaSpinner: UIImageView?

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defer {
            tableView.tableFooterView    = UIView()
            tableView.rowHeight          = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100
        }
        guard let controllers = splitViewController?.viewControllers else { return }
        detailViewController = (controllers[controllers.count - 1] as? UINavigationController)?.topViewController as? DetailTableViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController?.isCollapsed ?? true
        super.viewWillAppear(animated)
        pizzaSpinner?.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" { // FIXME: MOVE THIS ELSEWHERE
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selection = viewModel?.restaurant(indexPath: indexPath)
                let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailTableViewController
                controller?.detailItem = selection
                controller?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller?.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - TableViewDatasource Conformance

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.restaurantList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell       = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell, // FIXME: MOVE THIS ELSEWHERE
              let restaurant = viewModel?.restaurant(indexPath: indexPath) else { return tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath) }
        cell.configure(viewModel: RestaurantCellViewModel(restaurant: restaurant))
        return cell
    }

    @IBAction func updateMyLocation(sender: AnyObject) {
        toggleSpinningPizza()
        let locationManager = LocationManager.sharedInstance
        locationManager.delegate = self
        locationManager.updateLocation()
    }
    
    fileprivate func toggleSpinningPizza() {
        guard let pizzaSpinner = pizzaSpinner else { return }
        pizzaSpinner.isHidden = !pizzaSpinner.isHidden
        if pizzaSpinner.isHidden {
            pizzaSpinner.layer.removeAllAnimations()
        } else {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue      = .pi * 2.0
            rotationAnimation.duration     = 1.0
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount  = 100
            
            pizzaSpinner.layer.add(rotationAnimation, forKey: "rotationAnimation")
        }
    }
}

// MARK: - LocationManagerDelegate Conformance

extension MasterViewController: LocationManagerDelegate {
    func didUpdate(zipCode: String) {
        SearchService().results(for: zipCode) { response, error in
            self.toggleSpinningPizza()
            if error != nil {
                let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString("Unable to find any pizza near you.", comment: ""), preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in }
                alertController.addAction(defaultAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true)
                }
            }
            else if let response = response {
                self.viewModel = RestaurantListViewModel(restaurantList: response.restaurantList)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.tableHeaderView = UIView()
                }
            }
        }
    }
    
    func didFail(error: Error) {
        toggleSpinningPizza()
        let alertController = UIAlertController(title: NSLocalizedString("Location Error", comment: ""), message: NSLocalizedString("An error occurred while getting your location.", comment: ""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in }
        alertController.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}

