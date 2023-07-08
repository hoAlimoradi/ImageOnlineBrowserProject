//
//  HomeViewController.swift
//  Home
//
//  Created by hoseinAlimoradi on 7/8/23.
//

import UIKit
import Combine
import Commons
import SharedUI

class HomeViewController: UIViewController,
                            UICollectionViewDelegate {

    // MARK: - Properties
    private enum Constants {
        static var homeViewCornerRadious = CGFloat(8)
        static var homeViewTopMargin = CGFloat(10)
        static var homeViewLeadingMargin = CGFloat(20)
        static var homeViewTrailingMargin = CGFloat(-20)
        static var homeViewHeight = CGFloat(50)
        
        static var levelCollectionViewTopMargin = CGFloat(8)
        static var levelCollectionViewLeadingpMargin = CGFloat(8)
        static var levelCollectionViewTrailingMargin = CGFloat(-8)
        static var levelCollectionViewBottomMargin = CGFloat(-8)
        static var levelCollectionCellViewWidthMargin = CGFloat(24)
        static var levelCollectionCellViewheight = CGFloat(100)
        static var collectionViewUIEdgeInsets = CGFloat(4)
    }

    private let router: HomeRouting
    private var cancellables = Set<AnyCancellable>()
    let viewModel: HomeViewModelProtocol
 
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.text = "Collections" //AppStrings.Splash.title.localized
        //label.font = Fonts.Headings.regular
        label.textColor = Colors.BlackPearl.darkest
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private var homeCollcetionView: UICollectionView! = nil
    private var homeDataSource: UICollectionViewDiffableDataSource<HomeCollectionSection, HomeCollectionItemModel>?
    
    init(configuration: HomeModule.Configuration,
         viewModel: HomeViewModelProtocol,
         router: HomeRouting) {
        self.viewModel =  viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
         
        collcetionViewConfig(collectionViewLayout: configureLayouts())
        dataSourceConfig()
        
        view.addSubview(titleLabel)
        view.addSubview(homeCollcetionView)

        hideKeyboardWhenTappedAround()
        homeCollcetionView.keyboardDismissMode = .onDrag

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.homeViewTopMargin),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.homeViewLeadingMargin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.homeViewTrailingMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.homeViewHeight),
            
            homeCollcetionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.levelCollectionViewTopMargin),
            homeCollcetionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.levelCollectionViewLeadingpMargin),
            homeCollcetionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.levelCollectionViewTrailingMargin),
            homeCollcetionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.levelCollectionViewBottomMargin)])

        viewModel.action(.getCollections)
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.action(.showTabBar)
    }
     
    private func collcetionViewConfig(collectionViewLayout: UICollectionViewCompositionalLayout){
        homeCollcetionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        homeCollcetionView.delegate = self
        homeCollcetionView.register(HomeCollectionViewCell.self,
                                           forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollcetionView.showsVerticalScrollIndicator = false
        homeCollcetionView.translatesAutoresizingMaskIntoConstraints = false
    }
  
    private func bind() {
 
        self.viewModel.state
            .compactMap(\.collectionItems)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] collectionItems in
                guard let self else { return }
                let models = collectionItems.compactMap {
                    HomeViewController.HomeCollectionModel(id: $0.id,
                                                           title: $0.title,
                                                           description: $0.description,
                                                           isPrivate: $0.isPrivate,
                                                           mediaCount: $0.mediaCount,
                                                           photosCount: $0.photosCount,
                                                           videosCount: $0.videosCount)
                }
                self.updateCollection(models: models)
                }.store(in: &cancellables)
        
        self.viewModel.state
            .compactMap(\.route)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] routeAction in
                guard let self else { return }
                switch routeAction {
                case .details:
                    self.router.navigateToDetails(id: "")
//                case .showTabBar:
//                    self.router.showTabBar()
                }
            }.store(in: &cancellables)
    }
}


extension HomeViewController {
   func configureLayouts() -> UICollectionViewCompositionalLayout {

       let half = (self.view.frame.size.width - 10)
       let heightCell = half * 0.6
       
       let widthCell = (self.view.frame.size.width - 10)
       return UICollectionViewCompositionalLayout {
           (sectionNumber , ENV) -> NSCollectionLayoutSection in
           let item = NSCollectionLayoutItem(
               layoutSize: NSCollectionLayoutSize(
                   widthDimension: .estimated(widthCell),
                   heightDimension: .absolute(220)))
           let group = NSCollectionLayoutGroup.horizontal(
               layoutSize: NSCollectionLayoutSize(
                   widthDimension: .fractionalWidth(1),
                   heightDimension: .absolute(220)),
                   subitem: item, count: 1)
           group.interItemSpacing = .fixed(10)
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets.bottom = 28
           section.contentInsets.top = 29
           return section
       }
   }
}

//
extension HomeViewController {
   func dataSourceConfig() {
       homeDataSource = UICollectionViewDiffableDataSource<HomeCollectionSection, HomeCollectionItemModel>(
        collectionView: homeCollcetionView
       ) { (collectionView: UICollectionView, indexpath: IndexPath, item: HomeCollectionItemModel) -> UICollectionViewCell? in

           switch indexpath.section {
           case 0:
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexpath) as? HomeCollectionViewCell,
                     case let .homeCollectionModel(model) = item else { return nil }
               cell.config(with: model)
               return cell

           default:
               return nil
           }
       }
   }

   func updateCollection(models: [HomeCollectionModel]) {
       var snapshot = NSDiffableDataSourceSnapshot<HomeCollectionSection, HomeCollectionItemModel>()
       snapshot.appendSections([.homeSection])
       snapshot.appendItems(models.compactMap { HomeCollectionItemModel.homeCollectionModel($0) },
                            toSection: .homeSection)
       homeDataSource?.apply(snapshot, animatingDifferences: true)
   }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       switch indexPath.section {
       case HomeCollectionSection.homeSection.rawValue:
           print(indexPath.row)
           //self.viewModel.action(.updateUserTargets(indexPath.row))
       default:
           break
       }
   }
}
//
extension HomeViewController {
   enum HomeCollectionSection: Int, Hashable {
       case homeSection
   }
    
   struct HomeCollectionModel: Hashable, Identifiable, Equatable {
       let id: String
       let title: String
       let description: String
       let isPrivate: Bool
       let mediaCount: Int
       let photosCount: Int
       let videosCount: Int
   }

   enum HomeCollectionItemModel: Hashable {
       case homeCollectionModel(HomeCollectionModel)
   }
}
