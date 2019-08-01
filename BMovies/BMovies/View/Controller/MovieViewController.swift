//
//  MovieViewController.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {
    
    private var presenter = MoviePresenter()
    
    private var allMovies: [Movie] = []
    private var movies: [Movie] = []
    
    private var currentPage = 0
    private var totalPages = 1
    private var fetchingMovies = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLb: UILabel!
    @IBOutlet weak var tryAgainBtn: UIButton!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        self.collectionView.register(UINib(nibName: "MovieCollectionCell",
                                           bundle: nil), forCellWithReuseIdentifier: "cell")
        
        self.setupSearchBar()
        
        self.fetchMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.tabBarController?.delegate = self
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.tabBarController?.delegate = nil
    }

    private func fetchMovies() {
        if self.fetchingMovies || self.currentPage == self.totalPages {
            return
        }
        
        self.fetchingMovies = true
        
        self.presenter.getUpcomingMovies(page: self.currentPage + 1) { result in
            self.activityIndicator.stopAnimating()
            self.fetchingMovies = false
            
            switch result {
            case .success(let response):
                self.currentPage += 1
                self.totalPages = response.totalPages
                
                self.allMovies.append(contentsOf: response.results ?? [])
                self.uptadeMovies()
                
            case .failure(let error):
                if self.movies.count == 0 {
                    self.tryAgainBtn.isHidden = false
                }
                
                print(error.localizedDescription)
            }
        }
    }
    
    private func uptadeMovies() {
        func filter(_ movie: Movie, searchText: String) -> Bool {
            let searchText = searchText.trimmingCharacters(in: .whitespaces)
            let options: String.CompareOptions = [.diacriticInsensitive, .caseInsensitive]
            
            return movie.title?.range(of: searchText, options: options) != nil
                || movie.originalTitle?.range(of: searchText, options: options) != nil
        }
        
        if let searchText = self.searchController.searchBar.text, !searchText.isEmpty {
            self.movies = self.allMovies.filter({filter($0, searchText: searchText)})
            
            if self.movies.count == 0 {
                self.fetchMovies()
            }
        
        } else {
            self.movies = self.allMovies
        }
        
        UIView.animate(withDuration: 0.15) {
            self.noResultsLb.alpha = self.movies.count > 0 ? 0 : 1
        }
        
        self.collectionView.reloadData()
    }
    
    @IBAction func actionTryAgain(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        sender.isHidden = true
        
        self.fetchMovies()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)

        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
}

// MARK: UICollectionViewDelegate

extension MovieViewController: UICollectionViewDelegate,
                UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movie = self.movies[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! MovieCollectionCell
        
        cell.bind(movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Collection margin left and right (16 - 16)
        let contentWidth = (collectionView.frame.width - 16 - 16)
        let minWidth: CGFloat = 136
        let maxColumns = Int(ceil(contentWidth / minWidth))
        
        var width: CGFloat = 0
        for i in (1..<maxColumns).reversed() {
            let i = CGFloat(i)
            
            //Margin between columns (16)
            width = (contentWidth / i) - (16 / 2 * (i - 1))
            if width >= minWidth {
                break
            }
        }
        
        // 2:3 is the aspect ratio + top margin (4) + title height (36)
        let height = (width / (2 / 3)) + 4 + 36
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DetailViewController.show(from: self, movie: self.movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row >= self.movies.count - 1 {
            self.fetchMovies()
        }
    }
}

//MARK: UISearchResultsUpdating

extension MovieViewController: UISearchResultsUpdating {
    
    func setupSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.placeholder = "Search Movies".localized
        self.searchController.searchBar.barStyle = .black
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.uptadeMovies()
    }
}

// MARK: UITabBarDelegate

extension MovieViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self.parent && self.movies.count > 0 {
            self.collectionView.scrollToItem(at:
                IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

