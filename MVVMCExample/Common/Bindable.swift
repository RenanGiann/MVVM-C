//
//  Bindable.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 05/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T? {
        didSet {
            guard let value = value else { return }
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    init() {}
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindOnNext(_ listener: Listener?) {
        self.listener = listener
        guard let value = value else { return }
        listener?(value)
    }
    
}
