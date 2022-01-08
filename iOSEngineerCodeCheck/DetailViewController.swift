//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var langLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var repository: Repository?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        langLabel.text = "Written in \(repository?.language ?? "")"
        starsLabel.text = "\(repository?.stars ?? 0) stars"
        watchersLabel.text = "\(repository?.watchers ?? 0) watchers"
        forksLabel.text = "\(repository?.forks ?? 0) forks"
        issuesLabel.text = "\(repository?.issues ?? 0) open issues"
        titleLabel.text = repository?.fullName ?? ""
        getImage()
    }
    
    func getImage() {
        guard let owner = repository?.owner else {
            return
        }
        
        //リポジトリオーナのアバタ画像取得
        GithubAPI().fetchAvatarImage(avatarURL: owner.avatarURL) { img in
            DispatchQueue.main.async {
                self.imageView.image = img
            }
        }
    }
}
