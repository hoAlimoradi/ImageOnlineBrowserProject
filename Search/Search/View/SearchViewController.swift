//
//  SearchViewController.swift
//  Search
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import UIKit
import Combine
import Commons
import SharedUI

class SearchViewController: UIViewController,
                            UICollectionViewDelegate {

    // MARK: - Properties
    private enum Constants {
        static var searchViewCornerRadious = CGFloat(8)
        static var searchViewTopMargin = CGFloat(10)
        static var searchViewLeadingMargin = CGFloat(20)
        static var searchViewTrailingMargin = CGFloat(-20)
        static var searchViewHeight = CGFloat(50)
        
        static var levelCollectionViewTopMargin = CGFloat(8)
        static var levelCollectionViewLeadingpMargin = CGFloat(8)
        static var levelCollectionViewTrailingMargin = CGFloat(-8)
        static var levelCollectionViewBottomMargin = CGFloat(-8)
        static var levelCollectionCellViewWidthMargin = CGFloat(24)
        static var levelCollectionCellViewheight = CGFloat(100)
        static var collectionViewUIEdgeInsets = CGFloat(4)
    }

    private let router: SearchRouting
    private var cancellables = Set<AnyCancellable>()
    let viewModel: SearchViewModelProtocol
 
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.text = "Search" //AppStrings.Splash.title.localized
        //label.font = Fonts.Headings.regular
        label.textColor = Colors.BlackPearl.darkest
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var searchView: UISearchBar = {
        let view = UISearchBar()
        view.searchTextField.backgroundColor = Colors.BlackPearl.lightest
        view.searchTextField.textColor = Colors.BlackPearl.darkest
        view.searchTextField.font = Fonts.Button.regular
        view.searchBarStyle = .minimal
        view.searchTextField.layer.cornerRadius = Constants.searchViewCornerRadious
        view.searchTextField.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Search"
        view.searchTextField.addTarget(self,
                                       action: #selector(searchBarTextChanged(_:)),
                                       for: .editingChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var searchTasksCollcetionView: UICollectionView! = nil
    private var searchTasksDataSource: UICollectionViewDiffableDataSource<SearchTaskCollectionSection, SearchTaskCollectionItemModel>?
    
    init(configuration: SearchModule.Configuration,
         viewModel: SearchViewModelProtocol,
         router: SearchRouting) {
        self.viewModel =  viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func searchBarTextChanged(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        print("search text: \(text)")
        viewModel.action(.search(text))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
         
        collcetionViewConfig(collectionViewLayout: configureLayouts())
        dataSourceConfig()
        
        view.addSubview(searchView)
        view.addSubview(searchTasksCollcetionView)

        hideKeyboardWhenTappedAround()
        searchTasksCollcetionView.keyboardDismissMode = .onDrag

        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.searchViewTopMargin),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.searchViewLeadingMargin),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.searchViewTrailingMargin),
            searchView.heightAnchor.constraint(equalToConstant: Constants.searchViewHeight),
            
            searchTasksCollcetionView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: Constants.levelCollectionViewTopMargin),
            searchTasksCollcetionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.levelCollectionViewLeadingpMargin),
            searchTasksCollcetionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.levelCollectionViewTrailingMargin),
            searchTasksCollcetionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.levelCollectionViewBottomMargin)])

        viewModel.action(.search(nil))
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.action(.showTabBar)
    }
     
    private func collcetionViewConfig(collectionViewLayout: UICollectionViewCompositionalLayout){
        searchTasksCollcetionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        searchTasksCollcetionView.delegate = self
        searchTasksCollcetionView.register(SearchResultCollectionViewCell.self,
                                           forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        searchTasksCollcetionView.showsVerticalScrollIndicator = false
        searchTasksCollcetionView.translatesAutoresizingMaskIntoConstraints = false
    }
  
    private func bind() {
 
        self.viewModel.state
            .compactMap(\.images)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                guard let self else { return }
                let targetModelDataSource = images.compactMap {
                    SearchViewController.SearchTaskCollectionModel(id: UUID().uuidString,
                                                            idGenerated: $0.id,
                                                            name: $0.name)
                    
                }
                self.updateCollection(targetModels: targetModelDataSource)
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


extension SearchViewController {
   func configureLayouts() -> UICollectionViewCompositionalLayout {

       let half = (self.view.frame.size.width - 10)
       let heightCell = half * 0.6
       
       let widthCell = (self.view.frame.size.width - 10)
       return UICollectionViewCompositionalLayout {
           (sectionNumber , ENV) -> NSCollectionLayoutSection in
           let item = NSCollectionLayoutItem(
               layoutSize: NSCollectionLayoutSize(
                   widthDimension: .estimated(widthCell),
                   heightDimension: .absolute(90)))
           let group = NSCollectionLayoutGroup.horizontal(
               layoutSize: NSCollectionLayoutSize(
                   widthDimension: .fractionalWidth(1),
                   heightDimension: .absolute(90)),
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
extension SearchViewController {
   func dataSourceConfig() {
       searchTasksDataSource = UICollectionViewDiffableDataSource<SearchTaskCollectionSection, SearchTaskCollectionItemModel>(
        collectionView: searchTasksCollcetionView
       ) { (collectionView: UICollectionView, indexpath: IndexPath, item: SearchTaskCollectionItemModel) -> UICollectionViewCell? in

           switch indexpath.section {
           case 0:
               guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexpath) as? SearchResultCollectionViewCell,
                     case let .searchTaskCollectionModel(targetModel) = item else { return nil }
               cell.config(with: targetModel)
               return cell

           default:
               return nil
           }
       }
   }

   func updateCollection(targetModels: [SearchTaskCollectionModel]) {
       var snapshot = NSDiffableDataSourceSnapshot<SearchTaskCollectionSection, SearchTaskCollectionItemModel>()
       snapshot.appendSections([.searchResultTaskSection])
       snapshot.appendItems(targetModels.compactMap { SearchTaskCollectionItemModel.searchTaskCollectionModel($0) }, toSection: .searchResultTaskSection)
       searchTasksDataSource?.apply(snapshot, animatingDifferences: true)
   }

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       switch indexPath.section {
       case SearchTaskCollectionSection.searchResultTaskSection.rawValue:
           print(indexPath.row)
           //self.viewModel.action(.updateUserTargets(indexPath.row))
       default:
           break
       }
   }
}
//
extension SearchViewController {
   enum SearchTaskCollectionSection: Int, Hashable {
       case searchResultTaskSection
   }
   struct SearchTaskCollectionModel: Hashable, Identifiable, Equatable {
       let id: String
       let idGenerated: String
       let name: String
   }

   enum SearchTaskCollectionItemModel: Hashable {
       case searchTaskCollectionModel(SearchTaskCollectionModel)
   }
}




/*
 private func bind() {
     self.viewModel.state
         .compactMap(\.route)
         .receive(on: DispatchQueue.main)
         .sink { [weak self] routeAction in
             guard let self else { return }
             switch routeAction {
             case .details(let id):
                 self.router.navigateToDetails(id: id)
             }
         }.store(in: &cancellables)
 }

 */

