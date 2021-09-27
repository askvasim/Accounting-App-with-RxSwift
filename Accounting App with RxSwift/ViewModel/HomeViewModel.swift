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
    
    func getBalance(url: URL) -> Observable<Int>
    
}


class HomeViewModel: HomeNetworkProtocol {
    
    func getBalance(url: URL) -> Observable<Int> {
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        request.setValue("8918623815", forHTTPHeaderField: "Authorization")
        
        return Observable.just(url)
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }.map { response, data in
                if 200..<300 ~= response.statusCode {
                    let decodedData = try JSONDecoder().decode(AccountBalance.self, from: data)
                    return decodedData.balance
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }
    }
}
