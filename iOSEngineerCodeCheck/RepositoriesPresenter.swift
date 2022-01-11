//
//  RepositoriesPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 坂田和輝 on 2022/01/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepositoriesPresenterInput {
    var numberOfRepositories: Int { get }
    func repository(forRow row: Int) -> Repository
    func searchRepositories(searchWord: String)
    func cancelSearch()
    func didSelect(index: Int)
    func selectedRepository() -> Repository?
}

protocol RepositoriesPresenterOutput {
    func update()
}

class RepositoriesPresenter {
    private var githubAPIModel: GithubAPIModel
    private var output: RepositoriesPresenterOutput
    private var repositories = [Repository]()
    private var selectedIndex: Int?
    
    init(output: RepositoriesPresenterOutput) {
        self.output = output
        githubAPIModel = GithubAPIModel()
    }
}

extension RepositoriesPresenter: RepositoriesPresenterInput {
    var numberOfRepositories: Int {
        return repositories.count
    }
    
    func repository(forRow row: Int) -> Repository {
        return repositories[row]
    }
    
    func searchRepositories(searchWord: String) {
        githubAPIModel.searchRepositories(searchWord: searchWord) { repositories in
            self.repositories = repositories
            
            DispatchQueue.main.async {
                self.output.update()
            }
        }
    }
    
    func cancelSearch() {
        githubAPIModel.cancel()
    }
    
    func didSelect(index: Int) {
        selectedIndex = index
    }
    
    func selectedRepository() -> Repository? {
        guard let _selectedIndex = selectedIndex else {
            print("selectedIndex is nil")
            return nil
        }
        
        return repositories[_selectedIndex]
    }
}
