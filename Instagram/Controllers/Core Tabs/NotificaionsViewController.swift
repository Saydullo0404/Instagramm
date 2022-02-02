//
//  NotificaionsViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit
enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEvenTableViewCell.self, forCellReuseIdentifier: NotificationFollowEvenTableViewCell.identifier)
        
        
        return tableView
    }()
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        
        return spinner
    }()
    private lazy var  noNotificationView = NoNotificationsView()
    private var models = [UserNotification]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotification()
        navigationItem.title = "Notifications"
        view.backgroundColor    = .systemBackground
        view.addSubview(spinner)
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.showsVerticalScrollIndicator = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    private func fetchNotification() {
        for x in 0...100 {
            let user =
            User(username: "Saydullo",
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
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post): .follow(state: .not_following),
                                         text: "Hello World", user: user)
            models.append(model)
        }
    }
    private func addLayoutNotificationView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2)
        noNotificationView.center = view.center
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            // like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEvenTableViewCell.identifier, for: indexPath) as! NotificationFollowEvenTableViewCell
            //                        cell.configure(with: model)
            cell.delegate = self
            return cell
            
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}

// MARK: - Extension

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev Issue: Should never get called ")
        }
        // open the post
        
    }
    
    
}
extension NotificationsViewController: NotificationFollowEvenTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("tapped button")
        
        // perform database update
    }
    
    
    
    
}

