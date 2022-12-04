//
//  CharacterViewController.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/30.
//

import StoreKit
import UIKit

import RxCocoa
import RxGesture
import RxSwift

final class CharacterViewController: BaseViewController {
    let mainView = CharacterView()
    let viewModel = ShopSubViewModel()
    
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .sesacFocus
        requestProductData()
    }
    
    override func configureUI() {
        mainView.characterCollectionView.delegate = self
        mainView.characterCollectionView.dataSource = self
    }
    
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능")
            let request = SKProductsRequest(productIdentifiers: viewModel.characterProductIdentifiers)
            request.delegate = self
            request.start() //인앱 상품 조회
        } else {
            print("In App Purchase Not Enabled")
        }
    }
}

extension CharacterViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count > 0 {
            for i in products {
                productArray.append(i)
                product = i //옵션. 테이블뷰 셀에서 구매하기 버튼 클릭 시, 버튼 클릭 시
                
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription, "!!!!")
                viewModel.characterTitleArray.append(i.localizedTitle)
                viewModel.characterDescriptionArray.append(i.localizedDescription)
                viewModel.characterPriceArray.append(viewModel.numberFormatter.string(for: i.price) ?? "")
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.mainView.characterCollectionView.reloadData()
            }
        } else {
            print("No Product Found")
        }
    }
}

//영수증 검증
extension CharacterViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("queue: \(queue), updatedTransactions: \(transactions)")
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIdentifier: String) {
            let receiptFileURL = Bundle.main.appStoreReceiptURL
            let receiptData = try? Data(contentsOf: receiptFileURL!)
            let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
           
            print(receiptString)
            SKPaymentQueue.default().finishTransaction(transaction)
            
        }
}

extension CharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as? CharacterCollectionViewCell else {
            return UICollectionViewCell() }
        
        cell.characterImageView.image = UIImage(named: viewModel.setCharacterImage(index: indexPath.item))
        cell.titleLabel.text = viewModel.setCharacterTitle(index: indexPath.item)
        cell.descriptionLabel.text = viewModel.setCharacterDescription(index: indexPath.item)
        cell.buyButton.setTitle(viewModel.setCharacterPrice(index: indexPath.item), for: .normal)
        cell.buyButton.setEnabledButton(true)
        cell.buyButton.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind { (vc, _) in
                print("\(indexPath.item) button is tapped")
                
                if indexPath.item != 0 {
                    let payment = SKPayment(product: vc.productArray[indexPath.item - 1])
                    SKPaymentQueue.default().add(payment)
                    SKPaymentQueue.default().add(vc)
                }
            }
            .disposed(by: cell.cellDisposebag)
        
        return cell
    }
}
