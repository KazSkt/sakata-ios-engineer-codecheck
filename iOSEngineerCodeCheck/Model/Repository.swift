//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 坂田和輝 on 2022/01/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Owner: Codable {
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

struct Repository: Codable {
    var language: String?
    var stars: Int
    var watchers: Int
    var forks: Int
    var issues: Int
    var fullName: String
    var owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case forks = "forks_count"
        case issues = "open_issues_count"
        case fullName = "full_name"
        case owner = "owner"
    }
}

struct Items: Codable {
    var items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}
