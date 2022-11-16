//
//  LibraryAlbumsViewController.swift
//  OpenSpotify
//
//  Created by Mert Duran on 7.10.2022.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {

    var albums = [Album]()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        return tableView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
    }
    
    private func fetchData() {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums{[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albums):
                    self?.albums = albums
                    self?.updateUI()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }


        }
    }
    
    private func updateUI() {
        if albums.isEmpty {
            tableView.isHidden = true
        }else {
            tableView.reloadData()
            tableView.isHidden = false
        }
    }

}

extension LibraryAlbumsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier, for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(with:
            SearchResultSubtitleTableViewCellCellViewModel(title: album.name, subtitle: album.artists.first?.name ?? "-", imageURL: URL(string: album.images.first?.url ?? "")
                                                                      )
        
        
        )
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManager.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
