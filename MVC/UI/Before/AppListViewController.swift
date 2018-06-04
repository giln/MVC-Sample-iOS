//
//  AppListViewController
//  TestInteractivePlaygrounds
//
//  Created by Gil Nakache on 26/01/2016.
//  Copyright © 2016 Viseo. All rights reserved.
//

import UIKit

class AppListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Variables

    private var imageView = UIImageView()
    private var tableView = UITableView()
    private var allApps = [App]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(named: "bus")
        imageView = UIImageView(image: image)

        view.addSubview(tableView)
        view.addSubview(imageView)

        anchor(views: [imageView, tableView], useSafeAnchors: false)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        RestApiManager.getTopApps { apps in

            self.allApps = apps
            self.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDatasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allApps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = allApps[indexPath.row].name

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = allApps[indexPath.row]
        
        let detailVc = AppDetailViewController()
        detailVc.app = app

        navigationController?.pushViewController(detailVc, animated: true)
    }
}
