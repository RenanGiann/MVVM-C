//
//  SceneTransitionType.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 26/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

enum SceneTransitionType {
    case push(UIViewController)
    case present(UIViewController)
    case root(UIViewController)
}
