//
//  AppDetailViewController.swift
//  ModernMVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit

class AppDetailViewController: UIViewController {

    // MARK: - Variables

    var app: App? {
        didSet {
            title = app?.name
            descriptionLabel.text = app?.appDescription
            view.setNeedsLayout()
            view.setNeedsDisplay()
        }
    }

    private let contentView = UIView()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = UIColor.white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(descriptionLabel)

        descriptionLabel.backgroundColor = UIColor.white
        descriptionLabel.numberOfLines = 0
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        scrollView.frame = view.bounds

        let fitSize = descriptionLabel.sizeThatFits(CGSize(width: view.bounds.size.width - 20, height: CGFloat(MAXFLOAT)))

        contentView.frame = CGRect(x: 0, y: 0, width: fitSize.width + 20, height: fitSize.height + 20)

        descriptionLabel.frame = CGRect(x: 10, y: 10, width: fitSize.width, height: fitSize.height)

        scrollView.contentSize = contentView.bounds.size
    }
}
