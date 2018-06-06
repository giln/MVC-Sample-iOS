//
//  DownloadTableViewCell+Listable.swift
//  MVC
//
//  Created by Gil Nakache on 05/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func configure(with listItem: Listable, for indexPath: IndexPath, in tableView: UITableView) {
        textLabel?.text = listItem.title
        detailTextLabel?.text = listItem.description

        imageView?.image = nil
        setNeedsLayout()

        listItem.getImage { image in

            let cell = tableView.cellForRow(at: indexPath)

            cell?.imageView?.image = image
            cell?.setNeedsLayout()
        }
    }
}
