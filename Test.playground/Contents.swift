import Foundation
@testable import MVCFramework
import PlaygroundSupport
import UIKit
import XCTest

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

        addSubview(stackView)

    stackView.preservesSuperviewLayoutMargins = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading

        stackView.spacing = 15

        anchor(view: stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)


        contentView.backgroundColor = UIColor.red
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
        tableView.register(ListAppTableViewCell.self, forCellReuseIdentifier: ListAppTableViewCell.defaultReuseIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListAppTableViewCell.defaultReuseIdentifier, for: indexPath)

        let item = list[indexPath.row]

        print("sdqsd")
        (cell as? ListAppConfigurable)?.configure(listApp: item)

        print(cell)
        print(cell.contentView)
        print((cell as? ListAppTableViewCell)?.stackView)

        return cell
    }
}

struct Item {
    let title: String
    let description: String
}

extension Item: ListAppDisplayable {
}

let childController = ViewController()
childController.view.frame = CGRect(x: 0, y: 0, width: 500, height: 500)

childController.list = [Item(title: "test", description: "description")]
//
//let (parent, child) = playgroundControllers(device: .phone4_7inch, orientation: .portrait, child: childController)

PlaygroundPage.current.liveView = childController

