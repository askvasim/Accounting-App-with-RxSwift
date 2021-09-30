//
//  HomeViewModel.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeNetworkProtocol {
    
    func getBalance() -> Observable<Int>
    
    func getTransaction() -> Observable<[Transaction]>
    
    func creditAmount(amount: String, title: String) -> Observable<String>
    
    func debitAmount(amount: String, title: String) -> Observable<String>
    
}


class HomeViewModel: HomeNetworkProtocol {
    
    var disposedBag = DisposeBag()
    
    func getBalance() -> Observable<Int> {
        
        let resource = URL(string: "http://13.235.89.254:3001/api/balance")
        
        var request = URLRequest(url: resource!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.setValue("8918623815", forHTTPHeaderField: "Authorization")
        
        return Observable.just(resource)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }.map { response, data in
                if 200..<300 ~= response.statusCode {
                    let decodedData = try JSONDecoder().decode(AccountBalance.self, from: data)
                    return decodedData.balance!
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
    
    
    func getTransaction() -> Observable<[Transaction]> {
        
        let resource = URL(string: "http://13.235.89.254:3001/api/transactions")
        
        var request = URLRequest(url: resource!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.setValue("8918623815", forHTTPHeaderField: "Authorization")
        
        return Observable.just(resource)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }.map { response, data in
                if 200..<300 ~= response.statusCode {
                    let decodedData = try JSONDecoder().decode(TransactionData.self, from: data)
                    return decodedData.transactions
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
    
    func creditAmount(amount: String, title: String) -> Observable<String> {
        
        let resource = URL(string: "http://13.235.89.254:3001/api/credit")
        
        var request = URLRequest(url: resource!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("8918623815", forHTTPHeaderField: "Authorization")
        
        let userInput = ["amount": amount, "title": title]
        
        let requestedData = try? JSONSerialization.data(withJSONObject: userInput, options: [])
        request.httpBody = requestedData
        
        return Observable.just(resource)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }.map { response, data in
                if 200..<300 ~= response.statusCode {
                    let decodedData = try JSONDecoder().decode(TransactionResponse.self, from: data)
                    print(decodedData)
                    return decodedData.message
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
    
    func debitAmount(amount: String, title: String) -> Observable<String> {
        
        let resource = URL(string: "http://13.235.89.254:3001/api/debit")
        
        var request = URLRequest(url: resource!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("8918623815", forHTTPHeaderField: "Authorization")
        
        let userInput = ["amount": amount, "title": title]
        
        let requestedData = try? JSONSerialization.data(withJSONObject: userInput, options: [])
        request.httpBody = requestedData
        
        return Observable.just(resource)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }.map { response, data in
                if 200..<300 ~= response.statusCode {
                    let decodedData = try JSONDecoder().decode(TransactionResponse.self, from: data)
                    print(decodedData)
                    return decodedData.message
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }.asObservable()
    }
}


