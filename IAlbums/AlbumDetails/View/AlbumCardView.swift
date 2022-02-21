//
//  AlbumCardView.swift
//  IAlbums
//
//  Created by Сергей Даровских on 12.02.2022.
//

import UIKit

class AlbumCardView: UIView {
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateAlbumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(model: AlbumModel) {
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 6
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        configure(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.addSubview(albumImageView)
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            albumImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            albumImageView.heightAnchor.constraint(equalToConstant: 110),
            albumImageView.widthAnchor.constraint(equalToConstant: 110)
        ])
        self.addSubview(albumNameLabel)
        NSLayoutConstraint.activate([
            albumNameLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor),
            albumNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 14),
            albumNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        self.addSubview(artistNameLabel)
        NSLayoutConstraint.activate([
            artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 10),
            artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 14),
            artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        self.addSubview(dateAlbumLabel)
        NSLayoutConstraint.activate([
            dateAlbumLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 10),
            dateAlbumLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 14),
            dateAlbumLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
        ])
        self.addSubview(trackCountLabel)
        NSLayoutConstraint.activate([
            trackCountLabel.topAnchor.constraint(equalTo: dateAlbumLabel.bottomAnchor, constant: 10),
            trackCountLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 14),
            trackCountLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            trackCountLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    private func configure(model: AlbumModel) {
        ImageService.shared.getImage(imageURL: model.artworkUrl100) { image in
            self.albumImageView.image = image
        }
        albumNameLabel.text = model.collectionName
        artistNameLabel.text = model.artistName
        trackCountLabel.text = String(model.trackCount) + (model.trackCount == 1 ? " track" : " tracks")
        dateAlbumLabel.text = DateFormatHelper.formatDateFromAPI(dateFirst: model.releaseDate)
    }
}
