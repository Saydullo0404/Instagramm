//
//  PostViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit


/*
 Section
 - Header model
 Section
 - Post cell model
 Section
 -Action Buttons Cell model
 Section
 - n Number of general models for cemments
 
 */
///

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case action(provider: String) // like comment, share
    case comments(comments: [PostComment])
}
/// Model of render post

struct PostRenderViewModel {
    
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private let model: UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register cells
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.indentifier)
        tableView.register(IGFeedPostHederTableViewCell.self, forCellReuseIdentifier: IGFeedPostHederTableViewCell.indentifier)
        tableView.register(IGFeedActionsTableViewCell.self, forCellReuseIdentifier: IGFeedActionsTableViewCell.indentifier)
        tableView.register(IGPostGeneralTableViewCell.self, forCellReuseIdentifier: IGPostGeneralTableViewCell.indentifier)
        
        
        return tableView
    }()
    // MARK: - Init
    
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        // Action
        renderModels.append(PostRenderViewModel(renderType: .action(provider: "")))
        // 4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123\(x)",
                                        username: "@saydullo",
                                        text: "Great Post",
                                        createdDate: Date(),
                                        lakes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    
    
}
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .action(_):   return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_):         return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
            
        case .action(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedActionsTableViewCell.indentifier, for: indexPath) as!  IGFeedActionsTableViewCell
            
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralTableViewCell.indentifier, for: indexPath) as!  IGPostGeneralTableViewCell
            
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.indentifier, for: indexPath) as!  IGFeedPostTableViewCell
            
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHederTableViewCell.indentifier, for: indexPath) as!  IGFeedPostHederTableViewCell
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .action(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
            
        }
    }
}
