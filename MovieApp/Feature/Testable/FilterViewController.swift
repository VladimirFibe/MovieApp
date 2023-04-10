//
//  FilterViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 09.04.23.
//

import UIKit

class FilterViewController: UIViewController {
    
//    lazy var navigationButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.frame = CGRect(
//            x: 0,
//            y: 10,
//            width: view.frame.width,
//            height: 50)
//        button.setTitle("Open filter", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        button.backgroundColor = .orange
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        view.addSubview(navigationButton)
//        navigationButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
//        print(#function)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.view.frame = CGRect(
//            x: 0,
//            y: UIScreen.main.bounds.height / 5 * 2,
//            width: self.view.bounds.width,
//            height: UIScreen.main.bounds.height / 5 * 3)
//        self.view.layer.cornerRadius = 20
//        self.view.layer.masksToBounds = true
//
//        print(#function, view.frame)
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        print(#function)
//    }
//    
//    @objc func buttonPressed() {
//        print(#function)
//        dismiss(animated: true)
//    }
}




//class FilterViewController: UIViewController, UISheetPresentationControllerDelegate {
//
//    @available(iOS 15.0, *)
//    override var sheetPresentationController: UISheetPresentationController {
//            presentationController as! UISheetPresentationController
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        if #available(iOS 15.0, *) {
//            sheetPresentationController.delegate = self
//            sheetPresentationController.selectedDetentIdentifier = .medium
//            sheetPresentationController.prefersGrabberVisible = true
//            sheetPresentationController.detents = [.medium(), .large()]
//        }
//    }
//}
