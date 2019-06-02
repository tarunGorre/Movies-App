//
//  MovieDetailsViewController.swift
//  Movies App
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let inset: CGFloat = 5
    let minimumLineSpacing: CGFloat = 5
    let minimumInteritemSpacing: CGFloat = 5
    let cellsPerColumn = 1

    @IBOutlet var moviePosterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var movieDescLabel: UILabel!
    @IBOutlet var movieBackdropImageView: UIImageView!
    @IBOutlet var descHeightConstraint: NSLayoutConstraint!
    @IBOutlet var readMoreButton: UIButton!
    @IBOutlet var similarMoviesCollectionView: UICollectionView!
    
    var selectedMovie: Movie?
    var movieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        
    }
    
    func setUpUI() {
        moviePosterImageView.kf.indicatorType = .activity
        moviePosterImageView.kf.setImage(with: selectedMovie?.posterURL)
        movieBackdropImageView.kf.setImage(with: selectedMovie?.backdropURL)
        movieTitleLabel.text = selectedMovie?.title
        movieYearLabel.text = "(\(selectedMovie?.releaseYear ?? "--"))"
        movieDescLabel.text = selectedMovie?.overview
        readMoreButton.isHidden = true
        ShowOrHideReadMore()
        
        movieViewModel.fetchSimilarMovies(movieId: (selectedMovie?.id)!) { allMovies in
            DispatchQueue.main.async {
                self.similarMoviesCollectionView.reloadData()
            }
        }

    }
    
    // Readmore button will be shown/hidden based on the text size of description
    func ShowOrHideReadMore() {
        let descText = NSString(string: movieDescLabel.text ?? "")
        let maxSize = CGSize(width: movieDescLabel.frame.size.width, height: CGFloat(Float.infinity))
        let textSize = descText.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: movieDescLabel.font!], context: nil)

        if movieDescLabel.frame.height >= textSize.height {
            readMoreButton.isHidden = true
        } else {
            readMoreButton.isHidden = false
        }
    }
    
    // MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieViewModel.numberOfSimilarMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMovieCollectionCell", for: indexPath) as? SimilarMovieCollectionCell
        if let movie = self.movieViewModel.similarMovies?[indexPath.item] {
            cell?.configure(movie)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerColumn - 1)
        let itemHeight = ((collectionView.bounds.size.height - marginsAndInsets) / CGFloat(cellsPerColumn)).rounded(.down)
        return CGSize(width: itemHeight-50, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        pushToDetailsVC(at: indexPath)
    }

    func pushToDetailsVC(at indexPath: IndexPath) {
        let currentMovie = self.movieViewModel.similarMovies?[indexPath.row]
        let detailsVC: MovieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        detailsVC.selectedMovie = currentMovie
        detailsVC.title = currentMovie?.title
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    // MARK: - read more button action
    @IBAction func readMoreClicked(_ sender: UIButton) {
        if sender.title(for: .normal) == "...read more" {
            sender.setTitle("...less", for: .normal)
            descHeightConstraint.isActive = false
        } else {
            descHeightConstraint.isActive = true
            sender.setTitle("...read more", for: .normal)
        }
        self.view.layoutIfNeeded()
    }
    
}
