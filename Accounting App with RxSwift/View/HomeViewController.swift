//
//  ViewController.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    @IBOutlet weak var balanceLabel: UILabel!
    
    var disposedBag = DisposeBag()
    
    var homeViewModel: HomeNetworkProtocol!
    
    let resource = URL(string: "http://13.235.89.254:3001/api/balance")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fatchBalance(resource: resource!)
    }
    
    func fatchBalance(resource: URL) {
        
        let balance = homeViewModel.getBalance(url: resource)
            .observe(on: MainScheduler.instance)
            .retry(3)
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(0)
            }.asDriver(onErrorJustReturn: 0)
        
        balance.map { "₹ \($0)" }
            .drive(self.balanceLabel.rx.text)
            .disposed(by: disposedBag)
        
    }

    @IBAction func addButton(_ sender: Any) {
        
        let accountStoryboard: UIStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
        let transactionViewController = accountStoryboard.instantiateViewController(identifier: "TransactionViewControllerID") as! TransactionViewController
        
        navigationController?.pushViewController(transactionViewController, animated: true)
        
    }
}

