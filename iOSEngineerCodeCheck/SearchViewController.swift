//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [[String: Any]] = []
    
    var dataTask: URLSessionTask?
    var selectedIdx: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
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
        
        // 検索結果データをrepositoriesへ格納し、リストへ反映
        if searchWord.count != 0 {
            let apiSearchUrlStr = "https://api.github.com/search/repositories?q=\(searchWord)"
            
            // URLが不正である場合はreturn
            guard let apiSearchUrl = URL(string: apiSearchUrlStr) else {
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: apiSearchUrl) { (data, res, err) in
                // データがない場合return
                guard let _data = data else {
                    return
                }
                
                do {
                    guard let obj = try JSONSerialization.jsonObject(with: _data) as? [String: Any] else {
                        return
                    }

                    guard let items = obj["items"] as? [[String: Any]] else {
                        return
                    }
                    
                    self.repositories = items
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
            // これ呼ばなきゃリストが更新されません
            dataTask?.resume()
        }
        
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
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        selectedIdx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}
