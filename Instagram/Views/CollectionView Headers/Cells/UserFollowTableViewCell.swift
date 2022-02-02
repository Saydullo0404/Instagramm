//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by 1 on 22/01/22.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowButton(model: UserRelationship)
}

enum FollowState {
    case following        // indicates the current user is following the other user
    case not_following    // indicates the current user is Not following the other user
}

struct UserRelationship {
    let username: String
    let name:     String
    let type:     FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    weak var delegate: UserFollowTableViewCellDelegate?
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Saydullo"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
        
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@Saydullo"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
        
    }()
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
        
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        
    }
    @objc private func didTapFollowingButton() {
        guard let model = model else {
            return
        }

        delegate?.didTapFollowButton(model: model)
    }
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.username
        switch model.type {
            // show unfollow button
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.setTitleColor(.label, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            break
            // show following button
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .link
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 0
           
        }
        
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height - 6,
                                        height: contentView.height - 6)
        
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 200.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth,
                                    y: (contentView.height - 40)/2,
                                    width: buttonWidth,
                                    height: 40)
        
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right + 5,
                                 y: 0,
                                 width: contentView.width - 8 - profileImageView.width - buttonWidth,
                                 height: labelHeight)
        userNameLabel.frame = CGRect(x: profileImageView.right + 5,
                                     y: nameLabel.bottom,
                                     width: contentView.width - 8 - profileImageView.width - buttonWidth,
                                     height: labelHeight)
        
    }
    
    
    
}
