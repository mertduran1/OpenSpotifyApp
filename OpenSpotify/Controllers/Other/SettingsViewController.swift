//
//  SettingsViewController.swift
//  OpenSpotify
//
//  Created by Mert Duran on 12.10.2022.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        configureModels()
    }
    
    private func configureModels() {
        sections.append(Section(title: "Profil", options: [Option(title: "Profilini Gör", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))

        sections.append(Section(title: "Hesap", options: [Option(title: "Çıkış Yap", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.signOutTapped()
            }
        })]))
        
    }
    

    
    private func viewProfile() {
        let vc = ProfileViewController()
        vc.title = "Profile"
       // vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func signOutTapped() {
       let alert = UIAlertController(title: "Çıkış Yap",
                                     message: "Emin Misiniz?",
                                     preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Çıkış Yap", style: .destructive, handler: { _ in
            AuthManager.shared.signOut { [weak self] signedOut in
                if signedOut {
                    DispatchQueue.main.async {
                        let navVC = UINavigationController(rootViewController: WelcomeViewController())
                        navVC.navigationBar.prefersLargeTitles = true
                        navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: {
                            self?.navigationController?.popToRootViewController(animated: false)
                        })
                    }
                }
            }
        }))
        present(alert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Call handler for cll
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
