//
//  Date+Extension.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

extension Date {
    public func dateCompare(fromDate: Date) -> Bool {
        var validation: Bool = false
        let result: ComparisonResult = self.compare(fromDate)
        
        switch result {
        case .orderedAscending:
            validation = true
            break
        default:
            break
        }
        
        return validation
    }
    
    public func dateCompareToChat(fromDate: Date) -> ComparisonResult {
        let result: ComparisonResult = self.compare(fromDate)
        
        return result
    }
}
