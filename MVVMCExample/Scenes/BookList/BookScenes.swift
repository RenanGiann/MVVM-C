//
//  BookScenes.swift
//  MVVMCExample
//
//  Created by Renan on 26/06/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol BookScenesRouter {
    func book(viewModel: ViewModelType) -> SceneTransitionType
    func bookDetail(viewModel: DetailViewModelType) -> SceneTransitionType
}

class BookScenes: BookScenesRouter {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func book(viewModel: ViewModelType) -> SceneTransitionType {
        let nav = storyboard.instantiateViewController(identifier: "InitialNav") as! UINavigationController
        var viewController = nav.viewControllers.first as! ViewController
        viewController.bind(to: viewModel)
        return .root(nav)
    }
    
    func bookDetail(viewModel: DetailViewModelType) -> SceneTransitionType {
        var detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailViewController.bind(to: viewModel)
        return .push(detailViewController)
    }
    
}
