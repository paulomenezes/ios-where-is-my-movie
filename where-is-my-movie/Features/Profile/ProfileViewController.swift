//
//  ProfileViewController.swift
//  where-is-my-movie
//
//  Created by Paulo Menezes on 21/10/21.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var viewProfileIcons: [UIView]!
    @IBOutlet weak var stackViewLayout: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewProfileIcons.forEach { view in
            view.layer.cornerRadius = 10
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        rotate()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rotate()
    }
    
    func rotate() {
        if UIDevice.current.orientation.isLandscape {
            stackViewLayout?.axis = .horizontal
        } else {
            stackViewLayout?.axis = .vertical
        }
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
