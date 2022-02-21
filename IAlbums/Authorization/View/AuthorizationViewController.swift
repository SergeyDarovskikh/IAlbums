//
//  AuthorizationViewController.swift
//  IAlbums
//
//  Created by Сергей Даровских on 08.02.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    private let viewModel = AuthorizationViewModel()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet?"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextFild: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextFild: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 16
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let singInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPink
        button.setTitle("Sing In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let singUpButton: UIButton = {
        let button = UIButton(type: .system)
       
        button.setTitle("Sing Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.tintColor = .systemPink
        button.titleLabel?.attributedText = NSAttributedString(string: "Sing In", attributes:
                                                                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        self.navigationController?.viewControllers = [self]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Welcome"
    }
    
    @objc private func singInButtonTapped() {
        let signInResult = viewModel.tryToSignIn(email: emailTextFild.text ?? "",
                                                    password: passwordTextFild.text ?? "")
        
        switch signInResult {
        case .success(let user):
            let navVc = UINavigationController(rootViewController: AlbumsListViewController())
            navVc.modalPresentationStyle = .fullScreen
            self.present(navVc, animated: true)
        
            UserDefaultsManager.shared.saveActiveUser(user: user)
            
        case .error(let error):
            showDefaultAlert(title: "ERROR", message: error)
        }
    }   
        
    @objc private func singUpButtonTapped() {
        let singUpViewController = SignUpViewController()
        self.navigationController?.pushViewController(singUpViewController, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 165),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26)
        ])
        view.addSubview(emailTextFild)
        NSLayoutConstraint.activate([
            emailTextFild.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextFild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            emailTextFild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            emailTextFild.heightAnchor.constraint(equalToConstant: 54)
        ])
        view.addSubview(passwordLabel)
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTextFild.bottomAnchor, constant: 20),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26)
        ])
        view.addSubview(passwordTextFild)
        NSLayoutConstraint.activate([
            passwordTextFild.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextFild.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            passwordTextFild.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            passwordTextFild.heightAnchor.constraint(equalToConstant: 54)
        ])
        view.addSubview(singInButton)
        NSLayoutConstraint.activate([
            singInButton.topAnchor.constraint(equalTo: passwordTextFild.bottomAnchor, constant: 50),
            singInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 46),
            singInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -46),
            singInButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: singInButton.bottomAnchor, constant: 48),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(singUpButton)
        NSLayoutConstraint.activate([
            singUpButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: -1),
            singUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}



