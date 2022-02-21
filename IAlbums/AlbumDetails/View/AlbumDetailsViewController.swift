//
//  AlbumDetailsViewController.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    private let viewModel: AlbumDetailsViewModel
    
    private let tracksTitlelabel: UILabel = {
        let label = UILabel()
        label.text = "Tracks:"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.bounces = false
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(album: AlbumModel) {
        self.viewModel = AlbumDetailsViewModel(album: album)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupDelegate()
        setupNavigationBar()
        viewModel.fetchSong() { isFounded in
            if isFounded {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                self.showDefaultAlert(title: "Error", message: "Tracks not found")
            }
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.album.artistName
    }
    
    private func setupView(){
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        let albumCardView = AlbumCardView(model: viewModel.album)
        view.addSubview(albumCardView)
        NSLayoutConstraint.activate([
            albumCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            albumCardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            albumCardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        view.addSubview(tracksTitlelabel)
        NSLayoutConstraint.activate([
            tracksTitlelabel.topAnchor.constraint(equalTo: albumCardView.bottomAnchor, constant: 20),
            tracksTitlelabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
        ])

        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: tracksTitlelabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ _collectionView: UICollectionView, numberOfItemsInSection numberOfItems: Int) -> Int {
        return viewModel.songsArray.count
    }
    
    func collectionView(_ _collectionView: UICollectionView, cellForItemAt cellIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: cellIndexPath) as! SongCell
        let song = viewModel.songsArray[cellIndexPath.row].trackName ?? ""
        let trackNumber = cellIndexPath.row + 1
        cell.label.text = "\(trackNumber). \(song)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 30)
    }
}
