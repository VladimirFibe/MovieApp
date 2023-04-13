import UIKit

protocol CategoriesHeaderViewDelegate: AnyObject {
    func scrollToRow(with category: String)
}

final class CategoriesHeaderView: UITableViewHeaderFooterView {
    
    weak var delegate: CategoriesHeaderViewDelegate?
    
    private enum MainSection: Int {
        case main
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<MainSection, String>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<MainSection, String>
    
    static let identifier = "CategoriesHeaderView"
    
    private var categories: [String]
    private var dataSource: DataSource!
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    init(categories: [String]) {
        self.categories = categories
        super.init(reuseIdentifier: Self.identifier)
        
        
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        configureDataSource()
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories, toSection: .main)
        print(categories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout =  UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
//            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8), top: .fixed(5), trailing: .fixed(8), bottom: .fixed(5))
            let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .estimated(300), heightDimension: .fractionalWidth(1))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
            
            layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            
            return layoutSection
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        layout.configuration = config
        return layout
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell
            else { fatalError("Unable to dequeue \(CategoryCell.identifier)")}
            cell.configure(with: itemIdentifier)
            return cell
        }
    }
}

extension CategoriesHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell: CategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath) as? CategoryCell else { return }
//        cell.isSelected = true
//        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        delegate?.scrollToRow(with: categories[indexPath.row])
    }
}
