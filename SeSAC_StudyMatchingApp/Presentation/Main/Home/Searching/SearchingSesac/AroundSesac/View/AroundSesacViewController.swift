//
//  AroundSesacViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

class AroundSesacViewController: BaseViewController {
    let mainView = AroundSesacView()
    let disposeBag = DisposeBag()
    let viewModel = AroundSesacViewModel()
    var hiddenFlag: [Bool] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureUI() {
        mainView.tableView.register(AroundSesacTableViewCell.self, forCellReuseIdentifier: AroundSesacTableViewCell.reuseIdentifier)
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension AroundSesacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.searchedData?.fromQueueDB.count ?? 0
        hiddenFlag.append(contentsOf: Array<Bool>(repeating: true, count: count))
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AroundSesacTableViewCell.reuseIdentifier, for: indexPath) as? AroundSesacTableViewCell else { return UITableViewCell() }
        guard let data = viewModel.searchedData?.fromQueueDB[indexPath.row] else { return UITableViewCell() }
        cell.cardView.nicknameView.moreButton.tag = indexPath.row
        cell.cardView.nicknameView.nameLabel.text = data.nick
        cell.setImage(data.background, data.sesac)
        cell.cardView.titleView.isHidden = hiddenFlag[indexPath.row]
        cell.setSesacTitleColor(data.reputation)
        if data.reviews.count > 0 {
            cell.cardView.titleView.reviewLabel.text = data.reviews.joined(separator: "\n")
            cell.cardView.titleView.reviewLabel.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hiddenFlag[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
