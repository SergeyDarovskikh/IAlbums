//
//  SignUpTextCell.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class SignUpTextCell: UITableViewCell {
    static var height: CGFloat = 94
    
    var viewModel: SignUpTextCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            configure(viewModel: viewModel)
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let textFild: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        self.textFild.delegate = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.textFild.text = nil
        self.textFild.placeholder = nil
        self.errorLabel.text = nil
    }
    
    private func setupViews() {
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            containerView.heightAnchor.constraint(equalToConstant: 94)
        ])
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        titleLabel.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 50),
            errorLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 1),
            errorLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0),
            errorLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
        containerView.addSubview(textFieldBackgroundView)
        NSLayoutConstraint.activate([
            textFieldBackgroundView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            textFieldBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textFieldBackgroundView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: 54)
        ])
        textFieldBackgroundView.addSubview(textFild)
        NSLayoutConstraint.activate([
            textFild.leftAnchor.constraint(equalTo: textFieldBackgroundView.leftAnchor, constant: 18),
            textFild.rightAnchor.constraint(equalTo: textFieldBackgroundView.rightAnchor, constant: -18),
            textFild.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: SignUpTextCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.textFild.keyboardType = viewModel.keyboardType
        self.textFild.isSecureTextEntry = viewModel.fieldType == .password ? true : false
        
        viewModel.errorClosure = { error in
            print(error)
            self.errorLabel.text = error
        }
    }
}

extension SignUpTextCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel?.validate(value: textField.text ?? "")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if viewModel?.fieldType == .phone {
            guard let text = textField.text else { return true }
            if !text.contains("+7") {
                textField.text = "+7 (" + text
                return true
            }

            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString.format(with: "+X (XXX) XXX-XX-XX")

            return false
        } else {
            return true
        }
    }
}
