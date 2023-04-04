//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let button = MainButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        button.setButton(style: .fill, andTitle: "Bla")
    }

}
               
