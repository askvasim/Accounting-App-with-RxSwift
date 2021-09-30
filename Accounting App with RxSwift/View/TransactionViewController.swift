//
//  TransactionViewController.swift
//  Accounting App with RxSwift
//
//  Created by Vasim Khan on 9/27/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class TransactionViewController: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    var transectionViewModel: HomeNetworkProtocol!
    
    var disposedBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func creditButton(_ sender: UIButton) {
        
        let amount = amountTextField.text ?? ""
        let title = titleTextField.text ?? ""
        if title.isEmpty && amount.isEmpty {
            self.showAlert(with: "Please Add Value")
        } else {
            let credit = transectionViewModel.creditAmount(amount: amount, title: title)
                .observe(on: MainScheduler.instance)
                .catch { error in
                    print(error)
                    self.showAlert(with: error.localizedDescription)
                    return Observable.just("Error")
                }.asDriver(onErrorJustReturn: "Error")
            
            credit.drive().disposed(by: disposedBag)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func debitButton(_ sender: UIButton) {
        
        let amount = amountTextField.text ?? ""
        let title = titleTextField.text ?? ""
        if title.isEmpty && amount.isEmpty {
            self.showAlert(with: "Please Add Value")
        } else {
            let debit = transectionViewModel.debitAmount(amount: amount, title: title)
                .observe(on: MainScheduler.instance)
                .catch { error in
                    self.showAlert(with: error.localizedDescription)
                    return Observable.just("Error")
                }.asDriver(onErrorJustReturn: "Error")
            
            debit.drive().disposed(by: disposedBag)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}
