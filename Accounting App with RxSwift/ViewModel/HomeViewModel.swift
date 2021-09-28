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
    
}


class HomeViewModel: HomeNetworkProtocol {
    
    var disposedBag = DisposeBag()
    
    let resource = URL(string: "http://13.235.89.254:3001/api/balance")
    
    func getBalance() -> Observable<Int> {
        
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
            .retry(3)
            .catch { error in
                print (error.localizedDescription)
                return Observable.just(0)
            }
    }
}
