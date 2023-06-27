//
//  SplashView.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import UIKit
import Combine

class SplashViewController: UIViewController {

    // MARK: - Properties
    private enum Constants {
        static let delay = 0.5
    }

    private let router: SplashRouting
    private var cancellables = Set<AnyCancellable>()
    let viewModel: SplashViewModelProtocol
 
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.text = "Splash" //AppStrings.Splash.title.localized
        //label.font = Fonts.Headings.regular
        //label.textColor = Colors.BlackPearl.darkest
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(configuration: SplashModule.Configuration,
         viewModel: SplashViewModelProtocol,
         router: SplashRouting) {
        self.viewModel =  viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue //background
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        bind()
        viewModel.action(.getVersion)
    }

    private func bind() {
        self.viewModel.state
            .compactMap(\.route)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] routeAction in
                guard let self else { return }
                switch routeAction {
                case .home:
                    DispatchQueue.main.asyncAfter(deadline: .now() + Constants.delay) {[weak self] in
                        guard let self = self else {return}
                        self.router.navigateToMainTab()
                    }
                }
            }.store(in: &cancellables)
    }
}


