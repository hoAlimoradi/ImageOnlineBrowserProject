//
//  UIImageView+Extension.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {

    /*
     func setTokenizedImage(with url: String) {
         guard let url = URL(string: "http://\(Environment.imageBaseUrl)/\(url)") else {
             self.image = UIImage(named: "")
             return
         }
         let token  = UserService.shared.authorizationToken

         let modifier = AnyModifier { request in
             var req = request
             req.setValue(token, forHTTPHeaderField: "Authorization")
             return req
         }
         self.kf.setImage(with: url, options: [.requestModifier(modifier), .transition(.fade(1))]) { result in
             switch result {
             case .failure(let error):
                 print("jafar error: \(error)")
             case .success(let image):
                 print("jafar image: \(image)")
             }
         }
     }
     */
    
}


