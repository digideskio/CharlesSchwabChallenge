//
//  RestaurantTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - RestaurantTableViewCell

final class RestaurantTableViewCell: UITableViewCell {

    // MARK: - Property Delcarations
    
    @IBOutlet private var name:        UILabel?
    @IBOutlet private var distance:    UILabel?
    @IBOutlet private var address:     UILabel?
    @IBOutlet private var cityState:   UILabel?
    @IBOutlet private var phoneNumber: UILabel?
    
    private var viewModel: RestaurantCellViewModel?
    
    // MARK: - Nib Awakening
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - View Configuration

    func configure(viewModel: RestaurantCellViewModel) {
        self.viewModel    = viewModel
        name?.text        = viewModel.name
        distance?.text    = "\(viewModel.distance) mile(s)"
        address?.text     = viewModel.address
        cityState?.text   = viewModel.cityState
        phoneNumber?.text = viewModel.phoneNumber
    }
}
