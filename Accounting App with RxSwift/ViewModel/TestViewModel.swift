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
    
    
    func debitAmount(amount: String, title: String) -> Observable<String> {
        return Observable.just(message)
    }
    
    
    let message = "Dummy Message"
    
    func creditAmount(amount: String, title: String) -> Observable<String> {
        return Observable.just(message)
    }
    
    
    var TestTransactionData: [Transaction] = [
        Transaction (amount: 34410,
                     transactionAmount: 5000,
                     type: TypeEnum(rawValue: "credit")!,
                     title: "Test-1",
                     time: "2021-09-12T17:09:13.185Z",
                     id: "613e3439916f61a4db671f45"),
        Transaction (amount: 29410,
                     transactionAmount: 40,
                     type: TypeEnum(rawValue: "debit")!,
                     title: "Test-2",
                     time: "2021-09-12T17:07:30.912Z",
                     id: "613e33d2916f61a4db671ebf"),
        Transaction (amount: 29450,
                     transactionAmount: 30,
                     type: TypeEnum(rawValue: "debit")!,
                     title: "Test-3",
                     time: "2021-09-12T17:05:47.762Z",
                     id: "613e336b916f61a4db671e3c"),
        Transaction (amount: 29480,
                     transactionAmount: 500,
                     type: TypeEnum(rawValue: "debit")!,
                     title: "Test=4",
                     time: "2021-09-12T17:07:30.912Z",
                     id: "613e33d2916f61a4db671ebf"),
        Transaction (amount: 29980,
                     transactionAmount: 30,
                     type: TypeEnum(rawValue: "debit")!,
                     title: "Test-5",
                     time: "2021-09-12T17:07:30.912Z",
                     id: "613e33d2916f61a4db671ebf"),
        Transaction (amount: 30010,
                     transactionAmount: 10,
                     type: TypeEnum(rawValue: "credit")!,
                     title: "Test-6",
                     time: "2021-09-12T17:07:30.912Z",
                     id: "613e33d2916f61a4db671ebf"),
        Transaction (amount: 30000,
                     transactionAmount: 80,
                     type: TypeEnum(rawValue: "credit")!,
                     title: "Test-7",
                     time: "2021-09-12T17:07:30.912Z",
                     id: "613e33d2916f61a4db671ebf")
    ]
    
    func getTransaction() -> Observable<[Transaction]> {
        return Observable.of(TestTransactionData)
    }
    
    
    let balance = 40
    
    func getBalance() -> Observable<Int> {
        return Observable.just(balance)
    }
    
}
