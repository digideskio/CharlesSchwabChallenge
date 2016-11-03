//
//  DirectionsTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - DirectionsTableViewCell

final class DirectionsTableViewCell: DetailTableViewCell {

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
        guard let viewModel = viewModel as? DirectionsCellViewModel else { return }
        imageView?.image = UIImage(named: viewModel.imageName)
    }

}
