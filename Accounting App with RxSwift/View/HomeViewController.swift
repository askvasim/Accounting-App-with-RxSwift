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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let balance = homeViewModel.getBalance()
        balance.asDriver(onErrorJustReturn: 0)
                .map { "₹ \($0)" }
                .drive(self.balanceLabel.rx.text)
                .disposed(by: disposedBag)
        
    }
    

    @IBAction func addButton(_ sender: Any) {
        
        let accountStoryboard: UIStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
        let transactionViewController = accountStoryboard.instantiateViewController(identifier: "TransactionViewControllerID") as! TransactionViewController
        
        navigationController?.pushViewController(transactionViewController, animated: true)
        
    }
}

