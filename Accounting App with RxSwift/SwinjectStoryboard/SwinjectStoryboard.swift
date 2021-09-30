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
            
            swinject.register(HomeViewModel.self, name: "HomeNetworkProtocol") { r in
                DefaultHomeViewModel()
            }.inObjectScope(.container)
            
            swinject.storyboardInitCompleted(HomeViewController.self) { resolvable, viewController in
                viewController.homeViewModel = resolvable.resolve(HomeViewModel.self, name: "HomeNetworkProtocol")
            }
        
        swinject.storyboardInitCompleted(TransactionViewController.self) {resolvable, viewController in
            viewController.transectionViewModel = resolvable.resolve(HomeViewModel.self, name: "HomeNetworkProtocol")
        }
        
        }
    }
