//
//  PresentationManager.swift
//  MovieApp
//
//  Created by Павел Грицков on 10.04.23.
//

import UIKit

// навравлени презентации
enum  PresentationDirection {
   case bottom
}

class PresentationManager: NSObject {
    
    var direction: PresentationDirection = .bottom
}

extension PresentationManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = SlideInPresentationController(
            presented: presented,
            presenting: presenting,
            direction: direction)
          
        return presentationController
    }
}
