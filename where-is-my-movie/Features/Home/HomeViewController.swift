//
//  HomeViewController.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 19/10/21.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet weak var viewSearchContainer: UIView!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint?
    
    @IBOutlet var viewFilterContainers: [UIView]!
    
    @IBOutlet weak var viewMainContent: UIView!
    @IBOutlet weak var viewMainContentLeadingConstraint: NSLayoutConstraint?
    @IBOutlet weak var viewMainContentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMainContentCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMainConstraintTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var labelFeatured: UILabel!
    @IBOutlet weak var labelSeries: UILabel!
    
    var margin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSearchContainer.layer.cornerRadius = 16
        textFieldSearch.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "ColorTextSearch")!]
        )
        
        for viewFilterContainer in viewFilterContainers {
            viewFilterContainer.layer.cornerRadius = 16
        }
        
        margin = (view.bounds.width - (view.bounds.width * 0.85)) / 2
        
        configureCollectionView()
        
        rotate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rotate()
    }
    
    func rotate() {
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        if isLandscape {
            viewMainContentWidthConstraint?.isActive = false
            viewMainContentCenterXConstraint?.isActive = false
            viewMainContentWidthConstraint?.isActive = false

            collectionViewTopConstraint?.isActive = false
            collectionViewLeadingConstraint?.isActive = false
            collectionViewTrailingConstraint?.isActive = false
            collectionViewWidthConstraint?.isActive = false
            
            viewMainContentWidthConstraint = viewMainContent.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.6)
            viewMainContentWidthConstraint.isActive = true
            
            viewMainContentLeadingConstraint = viewMainContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
            viewMainContentLeadingConstraint?.isActive = true
            
            collectionViewTopConstraint = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            collectionViewTopConstraint.isActive = true
            
            collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: viewMainContent.trailingAnchor, constant: 32)
            collectionViewLeadingConstraint?.isActive = true
            
            collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            collectionViewTrailingConstraint.isActive = true
            
            collectionViewWidthConstraint = collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
            collectionViewWidthConstraint?.isActive = true
            
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 210, height: 310)
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: 0, right: 0)
            layout.minimumLineSpacing = 30
            
            collectionView.collectionViewLayout = layout
            
            labelFeatured.isHidden = true
            labelSeries.isHidden = true
        } else {
            labelFeatured?.isHidden = false
            labelSeries?.isHidden = false
            
            viewMainContentLeadingConstraint?.isActive = false
            viewMainContentWidthConstraint?.isActive = false
            viewMainContentCenterXConstraint?.isActive = false

            collectionViewTopConstraint?.isActive = false
            collectionViewWidthConstraint?.isActive = false
            collectionViewLeadingConstraint?.isActive = false
            collectionViewTrailingConstraint?.isActive = false
            
            viewMainContentWidthConstraint = viewMainContent.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
            viewMainContentWidthConstraint?.isActive = true
            
            viewMainContentCenterXConstraint = viewMainContent.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            viewMainContentCenterXConstraint.isActive = true
            
            collectionView.collectionViewLayout = collectionViewLayout()
            
            collectionView.topAnchor.constraint(equalTo: viewMainContent.bottomAnchor).isActive = true
            collectionViewLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            collectionViewLeadingConstraint?.isActive = true
            
            collectionViewTrailingConstraint = collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            collectionViewTrailingConstraint?.isActive = true
            
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
}

extension HomeViewController {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCollectionViewCellID")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = collectionViewLayout()
    }

    func collectionViewLayout() -> UICollectionViewFlowLayout {
        // 500 / x = 210
        // 400 / x = ?
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 210, height: 310)
//        layout.itemSize = CGSize(width: 210, height: collectionView.bounds.height)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.minimumLineSpacing = 30
        
        return layout
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCellID", for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
}
