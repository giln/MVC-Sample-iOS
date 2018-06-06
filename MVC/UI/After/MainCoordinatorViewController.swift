//
//  MainCoordinatorViewController.swift
//  MVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinatorViewController: UIViewController {

    // MARK: - Variables

    private let listViewController = ListViewController()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        add(asChildViewController: listViewController)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // FIXME: DI to do
        RestApiManager.getTopApps {[weak self] apps in

            self?.listViewController.list = apps
        }
    }
}
