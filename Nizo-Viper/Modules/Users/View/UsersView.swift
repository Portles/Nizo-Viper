//
//  View.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import Foundation
import UIKit

protocol UserViewProtocol: AnyObject {
    func setupView()
    func reloadTable()
    func changeTableVisibility(_ isHidden: Bool)
}

final class UserViewController: UIViewController {
    // swiftlint: disable implicitly_unwrapped_optional
    var presenter: UserPresenterProtocol!
    // swiftlint: enable implicitly_unwrapped_optional
    
    var tableView: UITableView = {
        let table: UITableView = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = .clear
        table.isHidden = true
        return table
    }()
    
    private let fetchButton: UIButton = {
        let button: UIButton = UIButton(configuration: UIButton.Configuration.filled())
        button.setTitle("Fetch", for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let clearButton: UIButton = {
        let button: UIButton = UIButton(configuration: UIButton.Configuration.filled())
        button.setTitle("Clear", for: .normal)
        button.tintColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidload()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 100)
        fetchButton.frame = CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width / 2 - 40, height: 64)
        clearButton.frame = CGRect(x: view.frame.width / 2 + 20, y: view.frame.height - 100, width: view.frame.width / 2 - 40, height: 64)
    }
}

extension UserViewController: UserViewProtocol {
    func setupView() {
        view.backgroundColor = .systemMint
        
        let fetchAction = UIAction { [weak self] _ in
            self?.presenter?.fetchUsers()
        }
        
        let clearAction = UIAction { [weak self] _ in
            self?.presenter?.clearUsers()
        }
        
        fetchButton.addAction(fetchAction, for: .primaryActionTriggered)
        clearButton.addAction(clearAction, for: .primaryActionTriggered)
        
        view.addSubview(fetchButton)
        view.addSubview(clearButton)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func changeTableVisibility(_ isHidden: Bool) {
        tableView.isHidden = isHidden
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getUserCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.getUserDataByIndex(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
