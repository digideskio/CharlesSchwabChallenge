//
//  DetailCellProtocol.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - DetailTableViewCell

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - View Configuration
    
    func configure(with viewModel: DetailCellViewModel) {
        selectionStyle = (viewModel.getAction() != nil) ? .default : .none
    }
}
