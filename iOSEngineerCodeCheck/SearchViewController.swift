//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [Repository] = []
    
    var dataTask: URLSessionTask?
    var selectedIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as? DetailViewController
            
            guard let _selectedIdx = selectedIdx else {
                print("selectedIdx is nil")
                return
            }
            
            detailVC?.repository = repositories[_selectedIdx]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = repositories[indexPath.row]
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedIdx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataTask?.cancel()
    }
    
    // キーボードのsearchボタンが押されたとき  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchBar.textがnilの場合はreturnする
        guard let searchWord = searchBar.text else {
            return
        }
        
        //検索結果を取得
        GithubAPI().searchRepositories(searchWord: searchWord) { repos in
            self.repositories = repos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
