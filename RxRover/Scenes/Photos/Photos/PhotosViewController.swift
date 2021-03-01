//
//  PhotosViewController.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import UIKit
import RxSwift

final class PhotosViewController: UIViewController {
    
//    private(set) var segmentedControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl()
//        return segmentedControl
//    }()
    
    private(set) var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomGridLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = UIRefreshControl()
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = nil
        collectionView.dataSource = nil
        return collectionView
    }()
    
    private(set) var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        return activityView
    }()
    
    private(set) var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(collectionView)
        view.addSubview(activityView)
        collectionView.constrainEdges(to: view)
        activityView.constrainXY(to: view)
    }
}
