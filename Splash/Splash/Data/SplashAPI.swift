//
//  SplashAPI.swift
//  Splash
//
//  Created by hoseinAlimoradi on 6/26/23.
//
import Foundation
import Combine

protocol SplashAPIProtocol {
    func getVersion() async throws -> String
}

final class SplashAPI: SplashAPIProtocol {

    enum SplashAPIError: Error {
        case invalidResponse
        case invalidSelf

        var localizedDescription: String {
            switch self {
            case .invalidResponse:
                return "AppStrings.Splash.invalidResponseError.rawValue"
            case .invalidSelf:
                return "AppStrings.Splash.invalidSelfError.rawValue"
            }
        }
    } 
    
    private var cancelables = Set<AnyCancellable>()

    func getVersion() async throws -> String {
        return "0.1"
    }
}
