//
//  DetailsViewController.swift
//  Detials
//
//  Created by hoseinAlimoradi on 7/9/23.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {

    // MARK: - Properties
    private enum Constants {
        static let delay = 0.5
    }

    private let router: DetailsRouting
    private var cancellables = Set<AnyCancellable>()
    let viewModel: DetailsViewModelProtocol
    
    private let collectionTitle: String
 
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        //label.text = "Details" //AppStrings.Splash.title.localized
        //label.font = Fonts.Headings.regular
        //label.textColor = Colors.BlackPearl.darkest
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(configuration: DetailsModule.Configuration,
         viewModel: DetailsViewModelProtocol,
         router: DetailsRouting) {
        self.viewModel =  viewModel
        self.router = router
        self.collectionTitle = configuration.collectionTitle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue //background
        view.addSubview(titleLabel)

        titleLabel.text = self.collectionTitle
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        bind()
        viewModel.action(.getphotos)
        viewModel.action(.getVideos)
    }

    private func bind() {
        self.viewModel.state
            .compactMap(\.route)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] routeAction in
                guard let self else { return }
                switch routeAction {
                case .pop:
                    DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
                        guard let self = self else {return}
                        self.router.popUpFromDetails()
                    }
                }
            }.store(in: &cancellables)
        
        self.viewModel.state
            .compactMap(\.photoItems)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] photoItems in
                guard let self else { return }
                print("photoItems.count : \(photoItems.count)")
            }.store(in: &cancellables)
        
        self.viewModel.state
            .compactMap(\.videoItems)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] videoItems in
                guard let self else { return }
                print("videoItems.count : \(videoItems.count)")
            }.store(in: &cancellables)
        
    }
}



