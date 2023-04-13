//import UIKit
//
//protocol SelectCollectionViewItemProtocol: AnyObject{
//    func selectItem(_ indexPath: IndexPath)
//}
//
//class HorizontalTagCollectionView: UICollectionView {
//
//    private let categoryLayout = UICollectionViewFlowLayout()
//    private let nameCategoryArray = ["all","Action","Adventure","Mystery","Horror","Comedian"]
//    
//    var cellDelegate: SelectCollectionViewItemProtocol?
//    
//    // MARK: - Init
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: .zero, collectionViewLayout: categoryLayout)
//        configure()
//    }
//    
//    // MARK: - Methods
//    private func configure(){
//        categoryLayout.minimumInteritemSpacing = 5
//        categoryLayout.scrollDirection = .horizontal
//        translatesAutoresizingMaskIntoConstraints = false
//        showsHorizontalScrollIndicator = false
//        delegate = self
//        dataSource = self
//        register(HorizontalTagCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellHorizontalCollection)
//        selectItem(at: [0,0], animated: false, scrollPosition: [])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
////MARK: CollectionView data source
//extension HorizontalTagCollectionView: UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return nameCategoryArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: Constants.cellHorizontalCollection, for: indexPath) as? HorizontalTagCollectionViewCell else {return UICollectionViewCell()}
//        cell.nameCategoryLabel.text = nameCategoryArray[indexPath.item]
//        return cell
//    }
//}
//
////MARK: CollectionView delegate
//extension HorizontalTagCollectionView: UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        cellDelegate?.selectItem(indexPath)
//    }
//}
//
////MARK: UICollectionViewDelegateFlowLayout setting size to cells
//extension HorizontalTagCollectionView: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let categoryFont = UIFont.systemFont(ofSize: 15)
//        let categoryAttributes = [NSAttributedString.Key.font: categoryFont as Any]
//        let categoryWidth = nameCategoryArray[indexPath.item].size(withAttributes: categoryAttributes).width + 40
//        return CGSize(width: categoryWidth, height: collectionView.frame.height)
//    }
//}
