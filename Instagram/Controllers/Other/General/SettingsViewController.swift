//
//  SettingisViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handle: (() -> Void)
}

/// View Controller to show user settings

final class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        return tableView
    }()
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureModels() {
        data.append([
            SettingCellModel(title: "Edit Profile ", handle: {
                [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invate Friends ", handle: {
                [weak self] in
                self?.didTapInvateFriends()
            }),
            SettingCellModel(title: "Save Orginal Posts", handle: {
                [weak self] in
                self?.didTapSaveOrginalPost()
            })
        ])
        data.append([
            SettingCellModel(title: "Terms of Service", handle: {
                [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handle: {
                [weak self] in
                self?.openURL(type: .privacy)
                
            }),
            SettingCellModel(title: "Help / Feeddback", handle: {
                [weak self] in
                self?.openURL(type: .help)
                
            })
        ])
        
        
        data.append([
            SettingCellModel(title: "Log Out ", handle: {
                [weak self] in
                self?.didTapLogOut()
            })
        ])
    }
    enum SettingsURLType {
        case terms, privacy, help
    }
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms:     urlString = "https://help.instagram.com/581066165581870"
        case .privacy:   urlString = "https://help.instagram.com/519522125107875"
        case .help:      urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {
            return
            
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    private func didTapSaveOrginalPost() {
        
    }
    private func didTapInvateFriends() {
        // Show share sheet to invate friends
        
    }
    private func didTapEditProfile() {
        let vc = EditRrofileViewController()
        vc.title = "Edit Profile"
        
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
        }))
        
        AuthManager.shared.logOut { success in
            DispatchQueue.main.async {
                if success {
                    // present log in
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true){
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                }
                else {
                    // error occurred
                    fatalError("Cloud not log out user ")
                }
            }
            actionSheet.popoverPresentationController?.sourceView = tableView
            actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
            
            present(actionSheet , animated: true)
        }
    }
    
    
    
    
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:  indexPath)
        
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handle()
        
    }
    
    
}
