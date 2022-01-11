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
    
    private var presenter: RepositoriesPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RepositoriesPresenter(output: self)
        
        searchBar.placeholder = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as? DetailViewController
            
            detailVC?.repository = presenter.selectedRepository()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepositories
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let rp = presenter.repository(forRow: indexPath.row)
        cell.textLabel?.text = rp.fullName
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        presenter.didSelect(index: indexPath.row)
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        //searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.cancelSearch()
    }
    
    // キーボードのsearchボタンが押されたとき  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchBar.textがnilの場合はreturnする
        guard let searchWord = searchBar.text else {
            return
        }
        
        //検索結果を取得
        presenter.searchRepositories(searchWord: searchWord)
    }
}

extension SearchViewController: RepositoriesPresenterOutput {
    func update() {
        tableView.reloadData()
    }
}
