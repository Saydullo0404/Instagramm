//
//  HomeViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit
import FirebaseAuth
import AVFoundation

struct HomeFeedRenderViewModel {
    
    let header:   PostRenderViewModel
    let post:     PostRenderViewModel
    let actions:  PostRenderViewModel
    let comments: PostRenderViewModel
    
}

class HomeViewController: UIViewController {
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        // Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.indentifier)
        tableView.register(IGFeedPostHederTableViewCell.self, forCellReuseIdentifier: IGFeedPostHederTableViewCell.indentifier)
        tableView.register(IGFeedActionsTableViewCell.self, forCellReuseIdentifier: IGFeedActionsTableViewCell.indentifier)
        tableView.register(IGPostGeneralTableViewCell.self, forCellReuseIdentifier: IGPostGeneralTableViewCell.indentifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func createMockModels() {
        let user =
        User(username: "@Saydullo",
             bio: "",
             name: (first: "", last: ""),
             profilePhoto: URL(string: "https://www.google.com")!,
             birthDate: Date(),
             gender: .male,
             counts: UserCount(followers: 1, following: 1, post: 1),
             joinDate: Date())
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postURL: URL(string: "https://www.google.com/")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedUsers: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(
                PostComment(
                    identifier: "\(x)",
                    username: "@jenny",
                    text: "This is the best I've seen",
                    createdDate: Date(),
                    lakes: []
                )
            )
        }
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .action(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
        
        
        
    }
    private func handleNotAuthenticated() {
        
        // Check auth status
        
        if Auth.auth().currentUser ==  nil {
            
            // Show login
            
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
            
        }
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4))/4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        
        if subSection == 0{
            // header
            return 1
            
        }else if subSection == 1 {
            // post
            return 1
            
        }else if subSection == 2 {
            // actions
            return 1
            
        }else if subSection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .action, .primaryContent: return 0
                
                
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }else{
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4))/4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHederTableViewCell.indentifier, for: indexPath) as! IGFeedPostHederTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
            case .comments, .action, .primaryContent: return UITableViewCell()
                
                
            }
        }else if subSection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.indentifier, for: indexPath) as!  IGFeedPostTableViewCell
                cell.configure(with: post)
                return cell
            case .comments, .action, .header: return UITableViewCell()
                
            }
            
        }else if subSection == 2 {
            // actions
            
            switch model.actions.renderType {
            case .action(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedActionsTableViewCell.indentifier, for: indexPath) as! IGFeedActionsTableViewCell
                
                cell.delegate = self
                return cell
                
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
            
        }else if subSection == 3 {
            // comments
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralTableViewCell.indentifier,for: indexPath) as! IGPostGeneralTableViewCell
                
                return cell
                
            case .header, .action, .primaryContent: return UITableViewCell()
                
            }
            
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Header
            return 70
        }
        else if subSection == 1 {
            // Post
            return tableView.width
        }
        else if subSection == 2{
            // Action (like/kommit)
            return 60
        }
        else if subSection == 3 {
            // Comment row
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        
        return subSection == 3 ? 70 : 0
        
    }
}
extension HomeViewController: IGFeedPostHederTableViewCellDelegate {
    func didTapMoreButton() {
        let actionShet = UIAlertController(title: "Post Options", message: nil, preferredStyle: .actionSheet)
        actionShet.addAction(UIAlertAction(title: "Report Post ", style: .destructive, handler: {[weak self] _ in
            self?.reportPost()
            
        }))
        actionShet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionShet, animated: true, completion: nil)
    }
    func reportPost() {
        
    }
}
extension HomeViewController: IGFeedActionsTableViewCellDelegate {
    func didTabLikeButton() {
        print("like")
    }
    
    func didTabCommentButton() {
        print("comment")
    }
    
    func didTabSendButton() {
        print("send")
    }
    
    
}
