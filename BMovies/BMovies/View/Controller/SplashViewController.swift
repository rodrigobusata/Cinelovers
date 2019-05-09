//
//  SplashViewController.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
    private var presenter: SplashPresenter?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = SplashPresenter()
        
        self.fetchGenres()
    }
    
    func fetchGenres() {
        self.presenter?.getGenreList() { result in
            switch result {
            case .success(let response):
                App.shared.genres = response.genres ?? []
                
                self.performSegue(withIdentifier: "main", sender: self)
                
            case .failure(let error):
                self.tryAgainBtn.isHidden = false
                print(error.localizedDescription)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func actionTryAgain(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        sender.isHidden = true
        
        self.fetchGenres()
    }
}
