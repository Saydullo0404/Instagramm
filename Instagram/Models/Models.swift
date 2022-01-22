//
//  Models.swift
//  Instagram
//
//  Created by 1 on 20/01/22.
//

import UIKit
enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}
struct UserCount{
    let followers: Int
    let following: Int
    let post: Int
}

public enum UserPostType {
    case photo, video
}
/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL  // either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createdData: Data
    let taggedUsers: [String]
}
struct PostLikes {
    let userName: String
    let postIdentifier: String
}
struct CommentLike {
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Data
    let lakes: [CommentLike]
    
}

