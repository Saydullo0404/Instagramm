//
//  ProfileinfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by 1 on 20/01/22.
//

import UIKit

protocol ProfileinfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileinfoHeaderCollectionReusableView )
    func profileHeaderDidTapFollowersButton(_ header: ProfileinfoHeaderCollectionReusableView )
    func profileHeaderDidTapFollowingButton(_ header: ProfileinfoHeaderCollectionReusableView )
    func profileHeaderDidTapEditProfileButton(_ header: ProfileinfoHeaderCollectionReusableView )
    
    
}

final class ProfileinfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileinfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileinfoHeaderCollectionReusableViewDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Post", for: .normal)
        return button
    }()
    private let followingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Following", for: .normal)
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        
        button.setTitle("Followers", for: .normal)
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        
        button.setTitle("Edit Your Profile", for: .normal)
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Saydullo"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the first account!"
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        addButtonAction()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    private func addButtonAction() {
        followersButton.addTarget(self,
                                  action: #selector(didTabFollowersButton),
                                  for: .touchUpInside)
        followingButton.addTarget(self,
                                  action: #selector(didTabFollowingButton),
                                  for: .touchUpInside)
        postsButton.addTarget(self,
                              action: #selector(didTabPostButton),
                              for: .touchUpInside)
        editProfileButton.addTarget(self,
                                    action: #selector(didTabEditProfileButton),
                                    for: .touchUpInside)
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
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5 + buttonHeight,
                                         width: countButtonWidth*3,
                                         height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width: width-10,
                                 height: 50).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5,
                                y: 5 + nameLabel.bottom,
                                width: width-10,
                                height: bioLabelSize.height).integral
        
        
    }
    //MARK: - Action
    
    @objc private func didTabFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTabFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTabPostButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTabEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
