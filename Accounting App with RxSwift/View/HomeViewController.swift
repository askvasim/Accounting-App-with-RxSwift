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
    @IBOutlet weak var transactionTableView: UITableView!
    
    var disposedBag = DisposeBag()
    
    var homeViewModel: HomeViewModel!
    var transactions: [Transaction]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        populateTransaction()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
        transactionTableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "CellIdentifier")
        
        let balance = homeViewModel.getBalance()
            .observe(on: MainScheduler.instance)
            .retry(3)
            .catch { [weak self] error in
                self?.showAlert(with: error.localizedDescription)
                return Observable.just(0)
            }.asDriver(onErrorJustReturn: 0)
        
        balance.map { "₹ \($0)" }
            .drive(self.balanceLabel.rx.text)
            .disposed(by: disposedBag)
        
//        populateTransaction()
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    private func populateTransaction() {
        let transactionDetails = homeViewModel.getTransaction()
            .observe(on: MainScheduler.instance)
            .retry(3)
            .catch({ error in
                self.showAlert(with: error.localizedDescription)
                return Observable.of([Transaction( amount: 0, transactionAmount: 0, type: TypeEnum(rawValue: "credit")!,
                                                     title: "", time: "", id: "")])
            })
            .asDriver(onErrorJustReturn: [Transaction.init(amount: 0, transactionAmount: 0, type: TypeEnum(rawValue: "credit")!, title: "", time: "", id: "")])
        
        transactionDetails.map { [weak self] transactions in
            self?.transactions = transactions
                self?.transactionTableView.reloadData()
        }.drive().disposed(by: disposedBag)
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let accountStoryboard: UIStoryboard = UIStoryboard(name: "Accounts", bundle: nil)
        let transactionViewController = accountStoryboard.instantiateViewController(identifier: "TransactionViewControllerID") as! TransactionViewController
        
        navigationController?.pushViewController(transactionViewController, animated: true)
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! TransactionTableViewCell
        
        
        
        cell.titleLabel.text = transactions?[indexPath.row].title
        cell.idLabel.text = transactions?[indexPath.row].id
        cell.timeLabel.text = transactions?[indexPath.row].time
        cell.balanceLabel.text = " Balance: ₹ \(transactions?[indexPath.row].amount ?? 0)"
        cell.transactionAmountLabel.text = "₹ \(transactions?[indexPath.row].transactionAmount ?? 0)"

        let credit = "credit"

        switch credit {
        case transactions?[indexPath.row].type.rawValue:
            cell.cellBackgroundView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        default:
            cell.cellBackgroundView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.5868732374, blue: 0.5450980663, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

