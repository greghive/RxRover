//
//  PhotosViewController.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import UIKit
import RxSwift

final class PhotosViewController: UIViewController {
    
    private(set) var segmentedContainer: UIView = {
        let segmentedContainer = UIView(frame: .zero)
        segmentedContainer.translatesAutoresizingMaskIntoConstraints = false
        segmentedContainer.backgroundColor = .secondarySystemBackground
        return segmentedContainer
    }()
    
    private(set) var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
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
        title = "Photos"
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedContainer)
        view.addSubview(collectionView)
        view.addSubview(activityView)
        
        segmentedContainer.addSubview(segmentedControl)
        segmentedContainer.constrainSafeTopAndSides(to: view)
        segmentedControl.constrainEdges(to: segmentedContainer, constant: 12)
        activityView.constrainCenter(to: view)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: segmentedContainer.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
