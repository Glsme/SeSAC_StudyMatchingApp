//
//  ReusableProtocol+Extension.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/07.
//

import UIKit

//MARK: - UICollectionViewCell + Extension
extension UICollectionViewCell: ReusableProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

