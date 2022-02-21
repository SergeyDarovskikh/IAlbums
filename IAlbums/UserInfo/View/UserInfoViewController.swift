//
//  UserInfoViewController.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class UserInfoViewController: UIViewController {
    private let viewModel = UserInfoViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: "userCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func logOutButtonTapped() {
        viewModel.logOut()
        let authorizationViewController = AuthorizationViewController()
        self.navigationController?.viewControllers = [authorizationViewController]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Account"
    }

    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        tableView.addSubview(logOutButton)
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46),
            logOutButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
}

extension UserInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRow(forIndexPath: indexPath)
    }
}

extension UserInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserInfoCell
            cell.model = viewModel.getModelForCell(atIndexPath: indexPath)
            cell.contentView.isUserInteractionEnabled = false
            return cell
    }
}


