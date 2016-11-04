//
//  DetailTableViewController.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - DetailTableViewController

final class DetailTableViewController: UITableViewController {

    // MARK: - Property Delcarations
    
    private var viewModel: DetailViewModel?
    
    var detailItem: Restaurant? {
        didSet {
            guard let detailItem = detailItem else { return }
            viewModel = DetailViewModel(restaurant: detailItem)
            configureView()
        }
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.tintColor = .darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - View Configuration
    
    private func configureView() {
        title = viewModel?.title
    }
    
    // MARK: - UITableViewDataSource Conformance
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.availableCells.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType      = viewModel?.availableCells[indexPath.row],
              let cellViewModel = viewModel?.cellViewModel(for: indexPath),
              let cell          = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier, for: indexPath) as? DetailTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        }
        cell.configure(with: cellViewModel)
        return cell
    }

    // MARK: - UITableViewDelegate Conformance
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        guard let action = viewModel?.cellViewModel(for: indexPath)?.action, let url = URL(string: action) else { return }
        UIApplication.shared.openURL(url)
    }
}
