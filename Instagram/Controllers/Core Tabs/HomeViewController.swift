//
//  HomeViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit
import FirebaseAuth

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
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: <#T##PostRenderViewModel#>,
                                                    post: <#T##PostRenderViewModel#>,
                                                    actions: <#T##PostRenderViewModel#>,
                                                    comments: <#T##PostRenderViewModel#>)
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
        }
        else {
            
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model    = feedRenderModels[position]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
            
        }else  if subSection == 1  {
            
            // post
            return 1
            
        }else  if subSection == 2  {
            
            // action
            return 1
            
        }else  if subSection == 3  {
            
            // comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return  comments.count > 2 ? 2 : comments.count
            case.header, .action, .primaryContent: return 0
                
            }
        }
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        }
        else {
            
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model    = feedRenderModels[position]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHederTableViewCell.indentifier, for: indexPath) as!  IGFeedPostHederTableViewCell
                
                return cell
            case .comments, .action, .primaryContent: return UITableViewCell()
            }
            
        }else  if subSection == 1  {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralTableViewCell.indentifier, for: indexPath) as!  IGPostGeneralTableViewCell
                
                return cell
            case .comments, .action, .header: return UITableViewCell()
            }
            
        }else  if subSection == 2  {
            
            // action
            let actionModel = model.actions
            switch actionModel.renderType {
            case .action(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedActionsTableViewCell.indentifier, for: indexPath) as!  IGFeedActionsTableViewCell
                
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
            
        }else  if subSection == 3  {
            
            // comments
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGPostGeneralTableViewCell.indentifier, for: indexPath) as!  IGPostGeneralTableViewCell
                
                return cell
            case .header, .action, .primaryContent: return UITableViewCell()
            }
        }
        
        
        return UITableViewCell()
        
        
    }
    
    
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let subSection = indexPath.section % 4
    if subSection == 0 {
        return 70
    }
    else if subSection == 1 {
        return tableView.width
    }
    else if subSection == 2 {
        return 60
    }
    else if subSection == 3 {
        return 50
    }
    return 0
}


