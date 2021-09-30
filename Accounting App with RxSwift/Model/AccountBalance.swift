//
//  AccountBalance.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import Foundation

struct AccountStatus: Codable {
    let accountBalance: AccountBalance
    
    static var empty: AccountStatus {
        return AccountStatus(accountBalance: AccountBalance(balance: 0, message: ""))
    }
}

struct AccountBalance: Codable {
    let balance: Int?
    let message: String?
}

