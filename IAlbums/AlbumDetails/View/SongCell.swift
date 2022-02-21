//
//  SongCell.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import UIKit

class SongCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setConstraints() {
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 30)
        ])
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            label.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            label.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -0)
        ])
    }
}
