//
//  SplashViewModel.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import Combine
import Foundation

final class SplashViewModel: SplashViewModelProtocol {

    private enum Constants {
    }

    // MARK: - Properties
    var state: CurrentValueSubject<SplashViewModelState, Never>
    let splashAPI: SplashAPIProtocol
     
    // MARK: - Initialize
    init(configuration: SplashModule.Configuration) {
        splashAPI = configuration.splashAPI
        state = .init(.init())
    }

    func action(_ handler: SplashViewModelAction) {
        switch handler {
        case .getVersion:
            getVersion()
        }
    }
 
    private func getVersion() {
        self.state.value = self.state.value.update(splashFetchState: SplashFetchState.loading)

        Task { [weak self] in
            guard let self = self else { return }
            do {
                let version = try await self.splashAPI.getVersion()
                self.state.value = self.state.value.update(route: .home, version: version)
            } catch {
                //TODO
                print("error.localizedDescription \(error.localizedDescription)")
            }
        }
    }
 
  
}


