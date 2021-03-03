//
//  PhotoViewController.swift
//  RxRover
//
//  Created by Greg Price on 27/02/2021.
//

import UIKit
import RxSwift 

final class PhotoViewController: UIViewController {
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) var cameraLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var solLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var roverLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo"
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        let stackContainer = UIView(frame: .zero)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.layer.cornerRadius = 8
        stackContainer.backgroundColor = .secondarySystemBackground
        view.addSubview(stackContainer)
        
        let stackGap: CGFloat = 12
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = stackGap
        stackContainer.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackContainer.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: stackGap),
            stackContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackGap),
            stackContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -stackGap),
            stackContainer.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: stackGap)
        ])
        
        stackView.constrainEdges(to: stackContainer, constant: stackGap)
        stackView.addArrangedSubview(roverLabel)
        stackView.addArrangedSubview(cameraLabel)
        stackView.addArrangedSubview(solLabel)
        stackView.addArrangedSubview(dateLabel)
    }
}

extension UISegmentedControl {
    func set(titles: [String], animated: Bool = false) {
        for (index, title) in titles.enumerated() {
            insertSegment(withTitle: title, at: index, animated: animated)
        }
    }
}

extension UILabel {
    func render(for tvt: PhotoLogic.TitleValueText) {
        let attributesA = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
                           NSAttributedString.Key.foregroundColor : UIColor.black]
        let attributesB = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
                           NSAttributedString.Key.foregroundColor : UIColor.black]
        render(stringA: tvt.title, attributesA: attributesA, stringB: tvt.value, attributesB: attributesB)
    }
}
