//
//  SignUpViewController.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    private let viewModel = SignUpViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(SignUpTextCell.self, forCellReuseIdentifier: "textCell")
        tableView.register(SignUpDateCell.self, forCellReuseIdentifier: "dateCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.setTitle("Sing In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        setupNavigationBar()
    }
    
    func setupDelegates() {
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
        
        tableView.addSubview(singUpButton)
        NSLayoutConstraint.activate([
            singUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            singUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
            singUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46),
            singUpButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Sing Up"
    }
    
    @objc private func singUpButtonTapped() {
        let isSuccessSignUp = viewModel.trySignUp()
        if isSuccessSignUp {
            let navVc = UINavigationController(rootViewController: AuthorizationViewController())
            navVc.modalPresentationStyle = .fullScreen
            self.present(navVc, animated: true)
        } else {
            self.showDefaultAlert(title: "ERROR", message: "Some items is not valid")
        }
    }
}

extension SignUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRow(forIndexPath: indexPath)
    }
}

extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getCellType(indexPath: indexPath) {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as! SignUpTextCell
            cell.viewModel = viewModel.getViewModelForCell(atIndexPath: indexPath) as? SignUpTextCellViewModel
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! SignUpDateCell
            cell.viewModel = viewModel.getViewModelForCell(atIndexPath: indexPath) as? SignUpDateCellViewModel
            cell.contentView.isUserInteractionEnabled = false
            return cell
        }
    }
}
