//
//  SwinjectStoryboard.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
            let swinject = defaultContainer
            
            swinject.register(HomeNetworkProtocol.self, name: "HomeNetworkProtocol") { r in
                HomeViewModel()
            }.inObjectScope(.container)
            
            swinject.storyboardInitCompleted(HomeViewController.self) { resolvable, viewController in
                viewController.homeViewModel = resolvable.resolve(HomeNetworkProtocol.self, name: "HomeNetworkProtocol")
            }
        }
    }
