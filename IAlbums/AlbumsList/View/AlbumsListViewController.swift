//
//  AlbumsListViewController.swift
//  IAlbums
//
//  Created by Сергей Даровских on 08.02.2022.
//

import UIKit

class AlbumsListViewController: UIViewController {
    
    private let viewModel = AlbumsListViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private let imageAlert = ImageAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegates()
        setupNavigationBar()
        setupConstraints()
        self.showImageAlert(type: .searchIsEmpty)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel.albums.isEmpty {
            let offsetY = view.safeAreaInsets.top + 1
            tableView.setContentOffset(CGPoint(x: 0, y: -offsetY), animated: false)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Albums"
        
        let userInfoButton = createBarButton(imageSystemName: "person.fill", selector: #selector(userInfoButtonTapped))
        navigationItem.rightBarButtonItem = userInfoButton
        
        navigationItem.searchController = searchController
    }
    
    @objc private func userInfoButtonTapped () {
        let userInfoViewController = UserInfoViewController()
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func showImageAlert(type: ImageAlert.AlertType) {
        imageAlert.type = type
        
        DispatchQueue.main.async {
            self.view.addSubview(self.imageAlert)
            NSLayoutConstraint.activate([
                self.imageAlert.leftAnchor.constraint(equalTo: self.tableView.leftAnchor, constant: 0),
                self.imageAlert.topAnchor.constraint(equalTo: self.tableView.topAnchor, constant: 0),
                self.imageAlert.rightAnchor.constraint(equalTo: self.tableView.rightAnchor, constant: 0),
                self.imageAlert.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 0)
            ])
        }
    }
    
    func removeImageAlert() {
        DispatchQueue.main.async {
            self.imageAlert.removeFromSuperview()
        }
    }
}

extension AlbumsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getHeightForRow(forIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoAlbumViewController = AlbumDetailsViewController(album: viewModel.albums[indexPath.row])
        
        navigationController?.pushViewController(infoAlbumViewController, animated: true)
    }
}

extension AlbumsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRowsInSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlbumCell
        cell.model = viewModel.getModelForCell(atIndexPath: indexPath)
        return cell
    }
}

extension AlbumsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.fetchAlbums(albumName: searchText) { isFound in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            if isFound {
                self.removeImageAlert()
            } else {
                self.showImageAlert(type: .notFound)
            }
        }
    }
}


