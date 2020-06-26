//
//  SceneCoordinator.swift
//  MVVMCExample
//
//  Created by Ginaldo Júnior on 26/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import UIKit

/**
 Scene coordinator, manage scene navigation and presentation.
 */

class SceneCoordinator: NSObject, SceneCoordinatorType {
    
    static var shared: SceneCoordinator!
    
    fileprivate var window: UIWindow
    fileprivate var currentViewController: UIViewController? {
        didSet {
            currentViewController?.navigationController?.delegate = self
            currentViewController?.tabBarController?.delegate = self
        }
    }
    
    required init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        var controller = viewController
        if let tabBarController = controller as? UITabBarController {
            guard let selectedViewController = tabBarController.selectedViewController else {
                return tabBarController
            }
            controller = selectedViewController
            
            return actualViewController(for: controller)
        }

        if let navigationController = viewController as? UINavigationController {
            controller = navigationController.viewControllers.first!
            
            return actualViewController(for: controller)
        }
        return controller
    }
    
    func transition(to scene: SceneTransitionType, completion: (() -> Void)?) {
        switch scene {
        case let .root(viewController):
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            
        case let .push(viewController):
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }

            navigationController.pushViewController(SceneCoordinator.actualViewController(for: viewController), animated: true)
            
        case let .present(viewController):
            viewController.modalPresentationStyle = .fullScreen
            currentViewController?.present(viewController, animated: true) {
                completion?()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        }
    }
    
    func pop(animated: Bool, completion: (() -> Void)?) {
        if let presentingViewController = currentViewController?.presentingViewController {
            currentViewController?.dismiss(animated: animated) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
                completion?()
            }
        } else if let navigationController = currentViewController?.navigationController {
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(currentViewController!)")
            }

            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController!)")
        }
    }
    
}

// MARK: - UINavigationControllerDelegate
extension SceneCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

// MARK: - UITabBarControllerDelegate
extension SceneCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)  {
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
}

