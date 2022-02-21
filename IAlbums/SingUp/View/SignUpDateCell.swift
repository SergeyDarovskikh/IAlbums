//
//  SignUpDateCell.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class SignUpDateCell: UITableViewCell {
    static var height: CGFloat = 94
    
    var viewModel: SignUpDateCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.titleLabel.text = viewModel.title
            viewModel.errorClosure = { error in
                print(error)
                self.errorLabel.text = error
            }
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
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
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
        containerView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        viewModel?.validate(value: datePicker.date)
    }
}
