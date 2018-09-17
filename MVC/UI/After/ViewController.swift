//
//  ViewController.swift
//  MVC
//
//  Created by Gil Nakache on 25/07/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit


protocol ListAppConfigurable {
    func configure(listApp: ListAppDisplayable)
}

extension ListAppTableViewCell: ListAppConfigurable {
    func configure(listApp: ListAppDisplayable) {
        titleLabel.text = listApp.title
        descriptionLabel.text = listApp.description
        print("configure")
    }
}

protocol ListAppDisplayable {
    var title: String { get }
    var description: String { get }
}

class ListAppTableViewCell: UITableViewCell {
    // MARK: - Variables

    let stackView = UIStackView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    // MARK: - Init

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        //stackView.preservesSuperviewLayoutMargins = true
        //stackView.isLayoutMarginsRelativeArrangement = true
        //stackView.spacing = 15

        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)

        print("anchor")
        contentView.anchor(view: stackView, useSafeAnchors: true)
    }
}

class ViewController: UITableViewController {
    // MARK: - Variables

    var list = [ListAppDisplayable]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.register(ListAppTableViewCell.self, forCellReuseIdentifier: ListAppTableViewCell.defaultReuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListAppTableViewCell.defaultReuseIdentifier, for: indexPath)

        let item = list[indexPath.row]

        print("sdqsd")
        (cell as? ListAppConfigurable)?.configure(listApp: item)

        return cell
    }
}
