//
//  IGPostGeneralTableViewCell.swift
//  Instagram
//
//  Created by 1 on 17/01/22.
//

import UIKit

class IGPostGeneralTableViewCell: UITableViewCell {

    static let indentifier = "IGPostGeneralTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // confgure the cell
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
