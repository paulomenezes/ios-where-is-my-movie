//
//  TabBarViewController.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 21/10/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = UIColor(named: "ColorBackground")
        tabBar.tintColor = UIColor(named: "ColorText")
        
        setupVCs()
    }
    
    fileprivate func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(
                for: HomeViewController(nibName: "HomeViewController", bundle: nil),
                title: "",
                image: UIImage(systemName: "house")!
            ),
//            createNavController(
//                for: DetailViewController(),
//                title: "",
//                image: UIImage(systemName: "play")!
//            ),
//            createNavController(
//                for: DetailViewController(),
//                title: "",
//                image: UIImage(systemName: "magnifyingglass")!
//            ),
            createNavController(
                for: ProfileViewController(nibName: "ProfileViewController", bundle: nil),
                title: "",
                image: UIImage(systemName: "person")!
            ),
        ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
