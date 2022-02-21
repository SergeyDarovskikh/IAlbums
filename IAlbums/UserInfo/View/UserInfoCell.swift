//
//  UserInfoCell.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class UserInfoCell: UITableViewCell {
    static var height: CGFloat = 94
    
    var model: UserInfoCellModel? {
        didSet {
            guard let model = self.model else { return }
            self.titleLabel.text = model.title
            self.valueLabel.text = model.value
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
    
    private let valueLabelBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.isUserInteractionEnabled = true
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        containerView.addSubview(valueLabelBackgroundView)
        NSLayoutConstraint.activate([
            valueLabelBackgroundView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            valueLabelBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabelBackgroundView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            valueLabelBackgroundView.heightAnchor.constraint(equalToConstant: 54)
        ])
        valueLabelBackgroundView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leftAnchor.constraint(equalTo: valueLabelBackgroundView.leftAnchor, constant: 18),
            valueLabel.rightAnchor.constraint(equalTo: valueLabelBackgroundView.rightAnchor, constant: -18),
            valueLabel.centerYAnchor.constraint(equalTo: valueLabelBackgroundView.centerYAnchor)
        ])
    }
}
