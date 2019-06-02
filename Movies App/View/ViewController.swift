//
//  ViewController.swift
//  Movies App
//
//  Created by Tarun Gorre on 01.06.19.
//  Copyright © 2019 Tarun Gorre. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let inset: CGFloat = 10
    let minimumLineSpacing: CGFloat = 5
    let minimumInteritemSpacing: CGFloat = 5
    let cellsPerRow = 2

    var movieViewModel = MovieViewModel()
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        movieViewModel.fetchTheNewMovies { allMovies in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

    }

    // MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return movieViewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell
        if let movie = self.movieViewModel.movies?[indexPath.item] {
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
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth+100)
    }

    // MARK: - Segue action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! CollectionCell
        let indexPaths = self.collectionView.indexPath(for: cell)
        let thisMovie = self.movieViewModel.movies?[indexPaths!.row]
        if let detailsVC = segue.destination as? MovieDetailsViewController {
            detailsVC.selectedMovie = thisMovie
            detailsVC.title = thisMovie?.title
        }
        
    }
}
