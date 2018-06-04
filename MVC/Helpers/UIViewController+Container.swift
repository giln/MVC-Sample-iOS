//
//  UIViewController+Container.swift
//  Tools
//
//  Created by Gil Nakache on 11/12/2017.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

/// Extension used to facilitate adding child viewControllers in a viewController
public extension UIViewController
{
    /// Embeds a view controller and also adds it's view in the view hierarchay
    ///
    /// - Parameter viewController: ViewController to add
    public func add(asChildViewController viewController: UIViewController, anchored: Bool = true)
    {
        // Notify Child View Controller before
        viewController.willMove(toParentViewController: self)

        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        if anchored
        {
            // Embeded viewControllers should not use safeAnchors
            anchor(view: viewController.view, useSafeAnchors: false)
        }

        // Notify Child View Controller after
        viewController.didMove(toParentViewController: self)
    }

    /// Removes a view controller from both view controller and view hierachies
    ///
    /// - Parameter viewControllerToRemove: ViewController to remove
    public func remove(viewControllerToRemove: UIViewController?)
    {
        guard let viewController = viewControllerToRemove else
        {
            return
        }

        // Notify Child View Controller before
        viewController.willMove(toParentViewController: nil)

        // Remove View
        viewController.view.removeFromSuperview()

        // Remove ViewController
        viewController.removeFromParentViewController()

        // Notify Child View Controller after
        viewController.didMove(toParentViewController: nil)
    }
}