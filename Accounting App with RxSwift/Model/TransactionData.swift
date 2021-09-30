//
//  TransactionData.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/28/21.
//

import Foundation

struct TransactionData: Codable {
    let transactions: [Transaction]
    
    static var empty: TransactionData {
        return TransactionData(
            transactions: [Transaction(
                amount: 0,
                transactionAmount: 0,
                type: TypeEnum(rawValue: "")!,
                title: "",
                time: "",
                id: ""
            )]
        )
    }
}

struct Transaction: Codable {
    let amount: Int
    let transactionAmount: Int
    let type: TypeEnum
    let title: String
    let time: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case amount
        case transactionAmount
        case type
        case title
        case time
        case id = "_id"
    }
}

enum TypeEnum: String, Codable {
    case credit = "credit"
    case debit = "debit"
}
