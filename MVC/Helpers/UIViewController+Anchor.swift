//
//  UIViewController+Anchor.swift
//  Tools
//
//  Created by Gil Nakache on 26/10/2017.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

/// Extension to simplify autolayout anchoring of views in a ViewController
public extension UIViewController
{
    /// Adds a view as a subview to the main view
    ///
    /// - Parameters:
    ///   - anchoredView: the view to anchor
    ///   - useSafeAnchor: should the view be anchored to the safeAreaLayoutGuide
    public func anchor(view anchoredView: UIView, useSafeAnchors: Bool = true)
    {
        anchoredView.translatesAutoresizingMaskIntoConstraints = false
        anchoredView.topAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor).isActive = true
        anchoredView.leadingAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor).isActive = true
        anchoredView.trailingAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor).isActive = true
        anchoredView.bottomAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor).isActive = true
    }

    /// Adds multiple views as subviews to the main view
    ///
    /// - Parameters:
    ///   - anchoredViews: an array of UIViews to anchor vertically
    public func anchor(views anchoredViews: [UIView], useSafeAnchors: Bool = true)
    {
        var previousAnchoredView: UIView?

        for anchoredView in anchoredViews
        {
            anchoredView.translatesAutoresizingMaskIntoConstraints = false

            // Si c'est la premiere vue on l'ancre en haut de l'ecran, sinon au bas de la vue précédente
            if previousAnchoredView == nil
            {
                anchoredView.topAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor).isActive = true
            }
            else
            {
                previousAnchoredView?.bottomAnchor.constraint(equalTo: useSafeAnchors ? anchoredView.safeAreaLayoutGuide.topAnchor : anchoredView.topAnchor).isActive = true
            }

            anchoredView.leadingAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.leadingAnchor : view.leadingAnchor).isActive = true
            anchoredView.trailingAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.trailingAnchor : view.trailingAnchor).isActive = true

            // Si c'est la derniere vue on l'ancre en bas de l'ecran
            if anchoredViews.last! == anchoredView
            {
                anchoredView.bottomAnchor.constraint(equalTo: useSafeAnchors ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor).isActive = true
            }

            previousAnchoredView = anchoredView
        }
    }

    public func fullAnchor(view anchoredView: UIView)
    {
        anchoredView.translatesAutoresizingMaskIntoConstraints = false
        anchoredView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        anchoredView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        anchoredView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        anchoredView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
