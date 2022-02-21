//
//  ImageAlert.swift
//  IAlbums
//
//  Created by Сергей Даровских on 08.02.2022.
//

import UIKit

class ImageAlert: UIView {
    
    var type: AlertType {
        set {
            DispatchQueue.main.async {
                switch newValue {
                case .searchIsEmpty:
                    self.imageView.image = UIImage(systemName: "magnifyingglass")
                    self.label.text = "Enter album name to search"
                case .notFound:
                    self.imageView.image = UIImage(systemName: "questionmark.circle")
                    self.label.text = "Album not found"
                }
            }
        }
        get {
            return self.type
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray4
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.frame.origin.y == 0 {
                self.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.frame.origin.y = 0
    }
    
    func setupViews() {
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    enum AlertType {
        case searchIsEmpty
        case notFound
    }
}
