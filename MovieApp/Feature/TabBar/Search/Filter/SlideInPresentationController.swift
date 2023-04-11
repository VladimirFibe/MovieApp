//
//  SlideInPresentationController.swift
//  MovieApp
//
//  Created by Павел Грицков on 10.04.23.
//

import UIKit

/*
 Контроллек который управляет перезодом между контроллерами
 статья -
 https://www.kodeco.com/3636807-uipresentationcontroller-tutorial-getting-started
 
 Stack over flow -
 https://stackoverflow.com/questions/42106980/how-to-present-a-viewcontroller-on-half-screen
 */

class SlideInPresentationController: UIPresentationController {
    
    private var direction: PresentationDirection
    private var dimmingView: UIView!
    
    init(presented: UIViewController,
         presenting: UIViewController?,
         direction: PresentationDirection) {
        self.direction = direction
        
        super.init(presentedViewController: presented, presenting: presenting)
        
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        guard let dimmingView = dimmingView else { return }
        
        containerView?.insertSubview(dimmingView, at: 0)
        
        guard let superView = dimmingView.superview else { return }
        // задаем затемненной вью размеры супервью
        NSLayoutConstraint.activate([
            dimmingView.heightAnchor.constraint(equalTo: superView.heightAnchor),
            dimmingView.widthAnchor.constraint(equalTo: superView.widthAnchor)
        ])
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
          }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
          })
    }
    
    override func dismissalTransitionWillBegin() {
      guard let coordinator = presentedViewController.transitionCoordinator else {
        dimmingView.alpha = 0.0
        return
      }
        
      coordinator.animate(alongsideTransition: { _ in
        self.dimmingView.alpha = 0.0
      })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .bottom:
            return CGSize(width: parentSize.width, height: parentSize.height * 0.5)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
      var frame: CGRect = .zero
        
      frame.size = size(forChildContentContainer: presentedViewController,
                        withParentContainerSize: containerView!.bounds.size)

      switch direction {
      case .bottom:
          frame.origin.y = containerView!.frame.height * 0.5
      }
      return frame
    }
}

// MARK: - Private
private extension SlideInPresentationController {
    // настройка затемнения
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        // alpha: 0.3 - затемнение
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        dimmingView.alpha = 0.0
        
        // добавляем Распознаватель жестов касания для затемненного вью
        let recognizer = UITapGestureRecognizer(
          target: self,
          action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    // это метод нужен для того чтоб мы кликнули на затемненную область и представленный VC закрылся
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
