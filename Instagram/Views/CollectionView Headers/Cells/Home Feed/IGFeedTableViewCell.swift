//
//  IGFeedTableViewCell.swift
//  Instagram
//
//  Created by 1 on 17/01/22.
//

import UIKit

final class IGFeedTableViewCell: UITableViewCell {
    
    static let indentifier = "IGFeedTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // confgure the cell 
    }
    
}
