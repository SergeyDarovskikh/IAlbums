//
//  AlbumCell.swift
//  IAlbums
//
//  Created by Сергей Даровских on 08.02.2022.
//

import UIKit

class AlbumCell: UITableViewCell {
    static let height: CGFloat = 90
    
    var model: AlbumModel? {
        didSet {
            guard let model = model else { return }
            configure(model: model)
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trackCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.albumImageView.image = nil
        self.albumNameLabel.text = nil
        self.trackCountLabel.text = nil
        self.artistNameLabel.text = nil
    }
    
    private func setViews() {
        self.backgroundColor = .clear
    }
    
    private func setConstraints() {
        self.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            containerView.heightAnchor.constraint(equalToConstant: 80),
        ])
        self.addSubview(albumImageView)
        NSLayoutConstraint.activate([
            albumImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            albumImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5),
            albumImageView.heightAnchor.constraint(equalToConstant: 70),
            albumImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        self.addSubview(albumNameLabel)
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            albumNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 10),
            albumNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            albumNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        self.addSubview(artistNameLabel)
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 15),
            artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 10),
            artistNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -75),
            artistNameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        self.addSubview(trackCountLabel)
        NSLayoutConstraint.activate([
            trackCountLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 15),
            trackCountLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            trackCountLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func configure(model: AlbumModel) {
        ImageService.shared.getImage(imageURL: model.artworkUrl100) { image in
            self.albumImageView.image = image
        }
        albumNameLabel.text = model.collectionName
        artistNameLabel.text = model.artistName
        trackCountLabel.text = "\(model.trackCount) tracks"
        trackCountLabel.text = String(model.trackCount) + (model.trackCount == 1 ? " track" : " tracks")
    }
}
