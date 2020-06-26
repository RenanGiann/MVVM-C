//
//  BindableType.swift
//  MVVMCExample
//
//  Created by Renan on 26/06/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol BindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get set }
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UIView {
    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }
}
