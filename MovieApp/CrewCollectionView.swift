//
//  CrewCollectionView.swift
//  MovieApp
//
//  Created by Alexey Davidenko on 14.04.2023.
//

import UIKit

struct CustomData {
    var memberImage: UIImage
    var name: String
    var jobTitle: String
}

class CrewCollectionView: UIViewController, UICollectionViewDelegate {
    
    fileprivate let data = [
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Ivan Ivanov", jobTitle: "director"),
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Andrey Andreev", jobTitle: "developer"),
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Anton Antonov", jobTitle: "manager"),
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Ivan Ivanov", jobTitle: "director"),
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Andrey Andreev", jobTitle: "developer"),
        CustomData(memberImage: #imageLiteral(resourceName: "avatarImage"), name: "Anton Antonov", jobTitle: "manager")
    ]
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CrewCustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}

extension CrewCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CrewCustomCell
        cell.data = self.data[indexPath.item]
        return cell
    }
}
