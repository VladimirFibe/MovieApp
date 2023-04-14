//
//  PopUpViewController.swift
//  MovieApp
//
//  Created by Марк Райтман on 14.04.2023.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    
    //MARK: - Properties
    //Свойство для хранения объекта-представления всплывающего окна
    var popup: UIView?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем кнопку
        let button = UIButton(type: .system)
        button.setTitle("Show Popup", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        // Добавляем констрейнты к кнопке
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Methods
    // Метод, выполняющийся при нажатии на кнопку
    @objc func buttonAction(sender: UIButton!) {
        
        // Создаем объект эффекта размытия
        let blurEffect = UIBlurEffect(style: .regular)
        
        // Создаем объект видимого представления с использованием эффекта размытия
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        // Устанавливаем размеры и позицию видимого представления
        blurView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        // Добавляем видимое представление на главное представление и делаем его невидимым
        view.addSubview(blurView)
        blurView.alpha = 0
        
        // Анимируем появление всплывающего окна с размытием в заднем фоне
        UIView.animate(withDuration: 0.3) { [self] in
            // Делаем видимое представление полностью прозрачным
            blurView.alpha = 1
            
            // Создаем всплывающее окно
            let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            popupView.center = self.view.center
            popupView.backgroundColor = Theme.whiteToBlack
            popupView.layer.cornerRadius = 10
            blurView.contentView.addSubview(popupView)
            
            // Добавляем заголовок
            let titleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: popupView.bounds.width, height: 20))
            titleLabel.textAlignment = .center
            titleLabel.text = "Change your picture"
            titleLabel.textColor = Theme.blackToWhite
            popupView.addSubview(titleLabel)
            
            // Добавляем разделитель
            let separator = UIView(frame: CGRect(x: 20, y: titleLabel.frame.maxY + 10, width: popupView.bounds.width - 40, height: 1))
            separator.backgroundColor = Theme.lightGreyToWhite
            popupView.addSubview(separator)
            
            // Добавляем кнопку "Take a photo"
            let takePhotoButton = UIButton(type: .system)
            takePhotoButton.frame = CGRect(x: 10, y: 50, width: 280, height: 40)
            takePhotoButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            takePhotoButton.imageView?.contentMode = .scaleAspectFit
            takePhotoButton.tintColor = Theme.blackToWhite
            takePhotoButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            takePhotoButton.titleEdgeInsets.left = 20
            takePhotoButton.setTitle("Take a photo", for: .normal)
            takePhotoButton.backgroundColor = Theme.lightGreyToBlack
            takePhotoButton.layer.cornerRadius = 5
            takePhotoButton.contentHorizontalAlignment = .left
            takePhotoButton.addTarget(self, action: #selector(takePhotoButtonTapped(_:)), for: .touchUpInside)
            popupView.addSubview(takePhotoButton)
            
            // Добавляем кнопку "Choose from your files"
            let chooseFileButton = UIButton(type: .system)
            chooseFileButton.frame = CGRect(x: 10, y: 100, width: 280, height: 40)
            chooseFileButton.setImage(UIImage(systemName: "folder.fill"), for: .normal)
            chooseFileButton.imageView?.contentMode = .scaleAspectFit
            chooseFileButton.tintColor = Theme.blackToWhite
            chooseFileButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            chooseFileButton.titleEdgeInsets.left = 20
            chooseFileButton.setTitle("Choose from your files", for: .normal)
            chooseFileButton.backgroundColor = Theme.lightGreyToBlack
            chooseFileButton.layer.cornerRadius = 5
            chooseFileButton.contentHorizontalAlignment = .left
            chooseFileButton.addTarget(self, action: #selector(chooseFileButtonTapped(_:)), for: .touchUpInside)
            popupView.addSubview(chooseFileButton)
            
            // Добавляем кнопку "Delete photo"
            let deletePhotoButton = UIButton(type: .system)
            deletePhotoButton.frame = CGRect(x: 10, y: 150, width: 280, height: 40)
            deletePhotoButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
            deletePhotoButton.imageView?.contentMode = .scaleAspectFit
            deletePhotoButton.tintColor = .red
            deletePhotoButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            deletePhotoButton.titleEdgeInsets.left = 25
            deletePhotoButton.setTitle("Delete photo", for: .normal)
            deletePhotoButton.backgroundColor = Theme.lightGreyToBlack
            deletePhotoButton.layer.cornerRadius = 5
            deletePhotoButton.contentHorizontalAlignment = .left
            deletePhotoButton.addTarget(self, action: #selector(deletePhotoButtonTapped(_:)), for: .touchUpInside)
            popupView.addSubview(deletePhotoButton)
            
            // Сохраняем ссылку на объект-представление в переменной popupView
            self.popup = popupView
        }
    }
    
    //Метод для скрытия всплывающего окна
    private func hidePopupView() {
        UIView.animate(withDuration: 0.2, animations: { [self] in
            popup?.alpha = 0
        }) { [self] (completed) in
            if completed {
                popup?.removeFromSuperview()
                popup = nil
                
                // Удаляем видимое представление с эффектом размытия
                for subview in view.subviews {
                    if subview is UIVisualEffectView {
                        subview.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    // Методы для действий при нажатии на кнопки
    @objc func takePhotoButtonTapped(_ sender: UIButton) {
        print("Take a photo button tapped")
        hidePopupView()
    }
    
    @objc func chooseFileButtonTapped(_ sender: UIButton) {
        print("Choose from your files button tapped")
        hidePopupView()
    }
    
    @objc func deletePhotoButtonTapped(_ sender: UIButton) {
        print("Delete photo button tapped")
        hidePopupView()
    }
}
