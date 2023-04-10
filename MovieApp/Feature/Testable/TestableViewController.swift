//
//  TestableViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 09.04.23.
//

import UIKit

class TestableViewController: BaseViewController {
    
    let presentationManager = PresentationManager()
    
    let navigationButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.setTitle("Open filter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .orange
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(navigationButton)
        
        navigationButton.center = view.center
        
        navigationButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }

    @objc func buttonPressed() {
        let vc = FilterViewController()
        
        // задаем направлени презентации VC
        presentationManager.direction = .bottom
        vc.transitioningDelegate = presentationManager
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true)
    }
}
