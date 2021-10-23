//
//  DetailViewController.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 19/10/21.
//

import UIKit

final class DetailViewController: UIViewController {
    var margin: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        margin = (view.bounds.width - (view.bounds.width * 0.85)) / 2
        
        configureNavigationBar()
        configureBackButton()
        configureFavoriteButton()
        configureLayout(size: view.bounds.size)
    }
    
    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func favorite() {
        //
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        configureLayout(size: size)
    }
}

extension DetailViewController {
    func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
    
    func configureBackButton() {
        self.navigationItem.setHidesBackButton(true, animated:false)

        let viewBackButton = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        viewBackButton.layer.cornerRadius = 5
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewBackButton.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewBackButton.addSubview(blurEffectView)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = UIImage(named: "NavBarBack")

        viewBackButton.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: viewBackButton.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: viewBackButton.centerYAnchor).isActive = true

        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        viewBackButton.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: viewBackButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func configureFavoriteButton() {
        self.navigationItem.setHidesBackButton(true, animated:false)

        let viewBackButton = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        viewBackButton.layer.cornerRadius = 5
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewBackButton.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewBackButton.addSubview(blurEffectView)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = UIImage(named: "NavBarFavorite")

        viewBackButton.addSubview(imageView)
        
        imageView.centerXAnchor.constraint(equalTo: viewBackButton.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: viewBackButton.centerYAnchor).isActive = true

        let backTap = UITapGestureRecognizer(target: self, action: #selector(favorite))
        viewBackButton.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: viewBackButton)
        self.navigationItem.rightBarButtonItem = leftBarButtonItem
    }
    
    func configureLayout(size: CGSize) {
        let isLandscape = UIDevice.current.orientation.isLandscape;
        
        view.backgroundColor = UIColor(named: "ColorBackground")
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentOffset = CGPoint.zero
//        scrollView.contentSize = size
        scrollView.contentSize = CGSize(width: isLandscape ? size.width / 2 : size.width, height: size.height + (isLandscape ? 0 : 100))
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = true
         
        view.subviews.forEach({ $0.removeFromSuperview() })

        view.addSubview(scrollView)
        
        if isLandscape {
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        } else {
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        }
        
        let coverContainer = UIView()
        coverContainer.translatesAutoresizingMaskIntoConstraints = false

        if isLandscape {
            view.addSubview(coverContainer)
            
            coverContainer.backgroundColor = .red
            
            coverContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            coverContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            coverContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
            coverContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        } else {
            scrollView.addSubview(coverContainer)

            coverContainer.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            coverContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            coverContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            coverContainer.heightAnchor.constraint(equalToConstant: 430).isActive = true
        }
        
        let imageView = UIImageView(image: UIImage(named: "Cover"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        coverContainer.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: coverContainer.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: coverContainer.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: coverContainer.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: coverContainer.trailingAnchor).isActive = true
        
        let gradientContainer = UIView()
        gradientContainer.translatesAutoresizingMaskIntoConstraints = false

        let gradient = CAGradientLayer()
        gradient.frame = imageView.bounds
        gradient.colors = [UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0), UIColor(named: "ColorBackground")!.cgColor]

        gradientContainer.layer.insertSublayer(gradient, at: 0)

        coverContainer.addSubview(gradientContainer)

        gradientContainer.centerXAnchor.constraint(equalTo: coverContainer.centerXAnchor).isActive = true
        gradientContainer.topAnchor.constraint(equalTo: coverContainer.topAnchor).isActive = true
        gradientContainer.bottomAnchor.constraint(equalTo: coverContainer.bottomAnchor).isActive = true
        gradientContainer.widthAnchor.constraint(equalTo: coverContainer.widthAnchor).isActive = true
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Money Heist : Part 5"
        title.textColor = .white // UIColor(named: "ColorText")
        title.font = UIFont(name: "Poppins-SemiBold", size: 24)
        
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.text = "2021 | Action, Crime, Drama | Episode - 8"
        detail.textColor = UIColor(named: "ColorTextDetail")
        detail.font = UIFont(name: "Poppins-Medium", size: 14)
        
        let starEmptyImage = UIImageView(image: UIImage(named: "StarEmpty"))
        starEmptyImage.translatesAutoresizingMaskIntoConstraints = false
        
        let starStackView = UIStackView(arrangedSubviews: [starFullImage(), starFullImage(), starFullImage(), starFullImage(), starEmptyImage])
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        starStackView.axis = .horizontal
        starStackView.spacing = 6
        
        let detailStackView = UIStackView(arrangedSubviews: [title, detail, starStackView])
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.axis = .vertical
        detailStackView.alignment = isLandscape ? .leading : .center
        detailStackView.spacing = 8
        
        scrollView.addSubview(detailStackView)
        
        if isLandscape {
            detailStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            detailStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
            detailStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        } else {
            detailStackView.topAnchor.constraint(equalTo: coverContainer.bottomAnchor, constant: -100).isActive = true
            detailStackView.leadingAnchor.constraint(equalTo: coverContainer.leadingAnchor).isActive = true
            detailStackView.trailingAnchor.constraint(equalTo: coverContainer.trailingAnchor).isActive = true
        }
        
        let textEpisodes = UILabel()
        textEpisodes.translatesAutoresizingMaskIntoConstraints = false
        textEpisodes.text = "Episodes"
        textEpisodes.font = UIFont(name: "Poppins-Medium", size: 18)
        textEpisodes.textColor = UIColor(named: "ColorText")
        
        scrollView.addSubview(textEpisodes)
        
        textEpisodes.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 24).isActive = true
        textEpisodes.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
        
        let episodesCollectionView = configureCollectionView()
       
        scrollView.addSubview(episodesCollectionView)
        
        episodesCollectionView.topAnchor.constraint(equalTo: textEpisodes.bottomAnchor, constant: 8).isActive = true
        episodesCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        episodesCollectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        episodesCollectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        if !isLandscape {
            let textPlot = UILabel()
            textPlot.translatesAutoresizingMaskIntoConstraints = false
            textPlot.text = "Plot"
            textPlot.font = UIFont(name: "Poppins-Medium", size: 24)
            textPlot.textColor = UIColor(named: "ColorText")
            
            scrollView.addSubview(textPlot)
            
            textPlot.topAnchor.constraint(equalTo: episodesCollectionView.bottomAnchor, constant: 28).isActive = true
            textPlot.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin).isActive = true
            
            let textPlotDescription = UILabel()
            textPlotDescription.translatesAutoresizingMaskIntoConstraints = false
            textPlotDescription.text = "Eight thieves take hostages and lock themselves in the Royal Mint of Spain as a criminal mastermind manipulates the police to carry out his plan."
            textPlotDescription.font = UIFont(name: "Poppins-Medium", size: 14)
            textPlotDescription.textColor = UIColor(named: "ColorTextDetail")
            textPlotDescription.numberOfLines = 0
            textPlotDescription.textAlignment = .justified
            
            scrollView.addSubview(textPlotDescription)
            
            textPlotDescription.topAnchor.constraint(equalTo: textPlot.bottomAnchor, constant: 4).isActive = true
            textPlotDescription.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            textPlotDescription.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.85).isActive = true
        }
    }
    
    func configureCollectionView() -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 110, height: 160)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.minimumLineSpacing = 32
        
        let collectionView = UICollectionView(frame: CGRect(x: 10, y: 10, width: 100, height: 100), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "episodeCollectionViewCellID")
        
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }

    
    func starFullImage() -> UIImageView {
        let starFullImage = UIImageView(image: UIImage(named: "StarFull"))
        starFullImage.translatesAutoresizingMaskIntoConstraints = false
        
        return starFullImage
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodeCollectionViewCellID", for: indexPath) as? EpisodeCollectionViewCell else {
            fatalError()
        }
        
        return cell
    }
}
