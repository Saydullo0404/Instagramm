//
//  IGFeedActionsTableViewCell.swift
//  Instagram
//
//  Created by 1 on 17/01/22.
//

import UIKit
protocol IGFeedActionsTableViewCellDelegate: AnyObject {
    func didTabLikeButton()
    func didTabCommentButton()
    func didTabSendButton()
}

class IGFeedActionsTableViewCell: UITableViewCell {
    weak var delegate: IGFeedActionsTableViewCellDelegate?
    static let indentifier = "IGFeedActionsTableViewCell"
    
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapLikeButton(){
        delegate?.didTabLikeButton()
    }
    @objc private func didTapCommentButton(){
        delegate?.didTabCommentButton()
    }
    @objc private func didTapSendButton(){
        delegate?.didTabSendButton()
    }
    
    public func configure(with post: UserPost) {
        // confgure the cell
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // like, comment, send
        let buttonSize = contentView.height - 10
        let buttons = [likeButton, commentButton, sendButton]
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10*CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
        }
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
