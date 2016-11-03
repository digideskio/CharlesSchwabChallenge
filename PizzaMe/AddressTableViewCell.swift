//
//  AddressTableViewCell.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import UIKit

// MARK: - AddressTableViewCell

final class AddressTableViewCell: DetailTableViewCell {

    // MARK: - Property Delcarations
    
    @IBOutlet var addressLabel:   UILabel?
    @IBOutlet var cityStateLabel: UILabel?
    
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
        guard let viewModel = viewModel as? AddressCellViewModel else { return }
        addressLabel?.text   = viewModel.address
        cityStateLabel?.text = viewModel.cityState
        imageView?.image     = UIImage(named: viewModel.imageName)
    }
}
