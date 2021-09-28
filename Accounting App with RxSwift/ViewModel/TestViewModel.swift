//
//  TestNetworkHandler.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import Foundation
import RxSwift
import RxCocoa

class TestViewModel: HomeNetworkProtocol {
    
    let balance = 40
    
    func getBalance() -> Observable<Int> {
        return Observable.just(balance)
    }
    
}
