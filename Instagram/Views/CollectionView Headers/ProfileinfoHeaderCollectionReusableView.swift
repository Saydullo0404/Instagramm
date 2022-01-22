//
//  ProfileinfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by 1 on 20/01/22.
//

import UIKit

class ProfileinfoHeaderCollectionReusableView: UICollectionReusableView {
        static let identifier = "ProfileinfoHeaderCollectionReusableView"
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        clipsToBounds = true
    }
    private func addSubview() {
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let profilePhotosize = width/4
        profilePhotoImageView.frame = CGRect(x: 5,
                                             y: 5,
                                             width: profilePhotosize,
                                             height: profilePhotosize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotosize/2.0
        
        let buttonHeight = profilePhotosize/2
        let countButtonWidth = (width-10-profilePhotosize)/3
        
        postsButton.frame = CGRect(x: profilePhotoImageView.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        followersButton.frame = CGRect(x: postsButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right,
                                   y: 5,
                                   width: countButtonWidth,
                                   height: buttonHeight).integral
        
    }
}
