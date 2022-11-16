//
//  WelcomeViewController.swift
//  OpenSpotify
//
//  Created by Mert Duran on 31.08.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OpenSpotify"
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.backgroundColor = .blue
        view.addSubview(signInButton)
        view.addSubview(label)
        view.addSubview(logoImageView)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds //view bounds tüm ekranı kaplar
        signInButton.frame = CGRect(x: 20,
                                    y: view.frame.height-50-view.safeAreaInsets.bottom,
                                    width: view.frame.width-40,
                                    height: 50)
        logoImageView.frame = CGRect(x: (view.frame.width-120)/2, y: (view.frame.height-350)/2, width: 120, height: 120)
        label.frame = CGRect(x: 30, y: logoImageView.frame.height+30, width: view.frame.width-60, height: 150)
        
        signInButton.addTarget(self, action: #selector(loginMi), for: .touchUpInside)
    }
    
    private let signInButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Giriş Yapınız", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
        
    }()
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "albums")
        return imageView
    }()
    
    private let logoImageView : UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        return logoImageView
    }()
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .orange
        label.font = .systemFont(ofSize: 32)
        label.text = "Milyonlarca Şarkıyı Dinle!"
        label.textColor = .systemGray6
        return label
        
    }()
    private let overlayView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
    
    @objc func loginMi() {
        let vc = AuthViewController()
                vc.completionHandler = { [weak self] success in
                    DispatchQueue.main.async {
                        self?.handleSignIn(success: success)
                    }
                }
                vc.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(vc, animated: true)
            }

            private func handleSignIn(success: Bool) {
                // Log user in or yell at them for error
                guard success else {
                    let alert = UIAlertController(title: "Oops",
                                                  message: "Something went wrong when signing in.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    present(alert, animated: true)
                    return
                }

                let mainAppTabBarVC = TabBarViewController()
                mainAppTabBarVC.modalPresentationStyle = .fullScreen
                present(mainAppTabBarVC, animated: true)
            }

}
