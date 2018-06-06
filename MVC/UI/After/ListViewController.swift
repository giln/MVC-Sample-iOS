//
//  ListViewController.swift
//  MVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit

protocol Listable {
    var title: String { get }
    var description: String { get }
    func getImage(completion: @escaping (UIImage?) -> Void)
}

class ListViewController: UITableViewController {

    // MARK: - Variables

    public var list = [Listable]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultReuseIdentifier)
    }

    // MARK: UITableViewDatasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultReuseIdentifier, for: indexPath)

        let listable = list[indexPath.row]
        cell.configure(with: listable, for: indexPath, in: tableView)

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
