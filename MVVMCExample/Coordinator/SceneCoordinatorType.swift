//
//  SceneCoordinatorType.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 26/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
    
    init(window: UIWindow)
    
    func transition(to scene: SceneTransitionType, completion: (() -> Void)?)
    func pop(animated: Bool, completion: (() -> Void)?)
}

extension SceneCoordinatorType {
    func transition(to scene: SceneTransitionType, completion: (() -> Void)? = nil) {
        transition(to: scene, completion: completion)
    }
}
