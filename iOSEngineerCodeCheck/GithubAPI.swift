//
//  GithubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 坂田和輝 on 2022/01/08.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GithubAPI {
    func searchRepositories(searchWord: String, completion: @escaping ([Repository]?) -> Void) {
        // 検索結果データをitemsへ
        if searchWord.count != 0 {
            let apiSearchUrlStr = "https://api.github.com/search/repositories?q=\(searchWord)"
            
            // URLが不正である場合はreturn
            guard let apiSearchUrl = URL(string: apiSearchUrlStr) else {
                return
            }
            
            let dataTask = URLSession.shared.dataTask(with: apiSearchUrl) { (data, res, err) in
                // データがない場合return
                guard let _data = data else {
                    return
                }
                
                do {
                    let obj = try JSONDecoder().decode(Items.self, from: _data)
                    
                    let items = obj.items
                    
                    completion(items)
                } catch {
                    print(error)
                }
            }
            dataTask.resume()
        }
    }
}
