//
//  Logging.swift
//  Commons
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import Foundation

public func LogError(_ message: String) {
    DispatchQueue.global(qos: .background).async {
    #if DEBUG
        print(" error:  \(message)")
    #endif        
    }
}
