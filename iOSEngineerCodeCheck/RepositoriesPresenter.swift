//
//  RepositoriesPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 坂田和輝 on 2022/01/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol RepositoriesPresenterInput {
    
}

protocol RepositoriesPresenterOutput {
    
}

class RepositoriesPresenter {
    private var output: RepositoriesPresenterOutput?
    private var repositories = [Repository]()
    
    init(output: RepositoriesPresenterOutput) {
        self.output = output
    }
}

extension RepositoriesPresenter: RepositoriesPresenterInput {
    
}
