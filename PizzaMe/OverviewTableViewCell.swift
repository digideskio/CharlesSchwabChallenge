//
//  OverviewTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - OverviewTableViewCell

final class OverviewTableViewCell: DetailTableViewCell {

    // MARK: - Property Delcarations
    
    @IBOutlet private var nameLabel:     UILabel?
    @IBOutlet private var cuisineLabel:  UILabel?
    @IBOutlet private var distanceLabel: UILabel?
    
    // MARK: - Nib Awakening
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - View Configuration
    
    override func configure(with viewModel: DetailCellViewModel) {
        super.configure(with: viewModel)
        guard let viewModel = viewModel as? OverviewCellViewModel else { return }
        nameLabel?.text     = viewModel.name
        distanceLabel?.text = viewModel.distance
    }
}

