//
//  TransactionsViewController.swift
//  Coordinator_v2
//
//  Created by Zin Lin Htet Naing on 27/02/2023.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    weak var coordinator: TransactionsCoordinator?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        initTableView()
        clickedMeButtonInit()
    }
    
    func initTableView(){
        view.addSubview(tableView)
        
        let nib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TransactionTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
      
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func clickedMeButtonInit() {
        clickMeButtonAction = { [weak self] cell in
            guard let self = self else { return }
            if let indexPath = self.tableView.returnIndexPath(cell: cell), let indexPathsForVisibleRows = self.tableView.indexPathsForVisibleRows {
                debugPrint("IndexPath", indexPath)
                debugPrint("indexPathsForVisibleRows", indexPathsForVisibleRows)
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
//                    cell.errorLabel.isHidden = !cell.clickedMeButton.isSelected
                    cell.errorLabel.isHidden = !(cell.textField.text?.isEmpty == true)
                    self.tableView.endUpdates()
                }
            }
        }
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier, for: indexPath) as? TransactionTableViewCell {
            cell.configCell(indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func returnIndexPath(cell: UITableViewCell) -> IndexPath? {
        guard let indexPath = self.indexPath(for: cell) else { return nil }
        return indexPath
    }
}
