//
//  MasterViewController.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit
//import QuartzCore

// MARK: - MasterViewController

final class MasterViewController: UITableViewController {
    
    fileprivate enum SortStyle: CustomStringConvertible {
        case name, distance
        
        fileprivate var description: String {
            switch self {
            case .distance: return "Sorted by: distance"
            case .name:     return "Sorted by: name"
            }
        }
    }
    
    private enum StoryBoardSegue: String {
        case showDetail
    }
    
    // MARK: - Property Delcarations
    
    private var detailViewController: DetailTableViewController? = nil
    fileprivate var viewModel:        RestaurantListViewModel?
    fileprivate var sortStyle: SortStyle = .distance {
        didSet { sortBarButton?.title = oldValue.description }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private var pizzaSpinner:  UIImageView?
    @IBOutlet weak private var sortBarButton: UIBarButtonItem?

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defer {
            tableView.tableFooterView    = UIView()
            tableView.rowHeight          = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100
            sortBarButton?.title = sortStyle.description
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
        guard let identifier = segue.identifier, let storyBoardSegue = StoryBoardSegue(rawValue: identifier) else { return }
        switch storyBoardSegue {
        case .showDetail:
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let selection = viewModel?.restaurant(indexPath: indexPath)
            let controller = (segue.destination as? UINavigationController)?.topViewController as? DetailTableViewController
            controller?.detailItem = selection
            controller?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller?.navigationItem.leftItemsSupplementBackButton = true
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

    // MARK: - IBActions
    
    @IBAction private func updateMyLocation(sender: AnyObject) {
        toggleSpinningPizza()
        let locationManager = LocationManager.sharedInstance
        locationManager.delegate = self
        locationManager.updateLocation()
    }
    
    @IBAction private func sortRestaurants(_ sender: UIBarButtonItem) {
        guard let restaurants = viewModel?.restaurantList else { return }
        setRestaurantListViewModel(restaurants: restaurants)
    }
    
    // MARK: - Helper Methods
    
    fileprivate func setRestaurantListViewModel(restaurants: [Restaurant]) {
        let predicate: (Restaurant, Restaurant) -> Bool
        switch sortStyle {
        case .distance: predicate = { $0.distance < $1.distance }
                        sortStyle = .name
        case .name:     predicate = { $0.name < $1.name }
                        sortStyle = .distance
        }
        viewModel = RestaurantListViewModel(restaurantList: restaurants, predicate: predicate)
        tableView.reloadData()
    }
    
    fileprivate func toggleSpinningPizza() {
        guard let pizzaSpinner = pizzaSpinner else { return }
        pizzaSpinner.isHidden = !pizzaSpinner.isHidden
        guard !pizzaSpinner.isHidden else {
            pizzaSpinner.layer.removeAllAnimations()
            return
        }
        let rotationAnimation          = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue      = .pi * 2.0
        rotationAnimation.duration     = 1.0
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount  = 100
        
        pizzaSpinner.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}

// MARK: - LocationManagerDelegate Conformance

extension MasterViewController: LocationManagerDelegate {
    func didUpdate(zipCode: String) {
        SearchService().results(for: zipCode) { response, error in
            self.toggleSpinningPizza()
            guard let response = response else {
                guard let error = error else { return }
                DispatchQueue.main.async { self.presentErrorAlertController(title: "Error", message: "Unable to find any pizza near you:\n\(error.localizedDescription)") }
                return
            }
            DispatchQueue.main.async {
                self.setRestaurantListViewModel(restaurants: response.restaurantList)
                self.tableView.tableHeaderView = UIView()
            }
        }
    }
    
    func didFail(error: Error) {
        toggleSpinningPizza()
        DispatchQueue.main.async {
            self.presentErrorAlertController(title: "Location Error", message: "An error occurred while getting your location:\n\(error.localizedDescription)")
        }
    }
    
    fileprivate func presentErrorAlertController(title: String, message: String, preferredstyle: UIAlertControllerStyle = .alert, actionTitle: String = "OK", actionStyle: UIAlertActionStyle = .default, actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredstyle)
        let defaultAction   = UIAlertAction(title: actionTitle, style: actionStyle, handler: actionHandler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
}
