//
//  BirthViewModel.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/10.
//

import Foundation

import RxCocoa

final class BirthViewModel: CommonViewModel {
    struct Input {
        let nextButton: ControlEvent<Void>
        let textField: ControlProperty<String?>
    }
    
    struct Output {
        let nextButtonTapped: ControlEvent<Void>
        let dateTextField: ControlEvent<String>
    }
    
    func transform(input: Input) -> Output {
        let nextButtonTapped = input.nextButton
        let textField = input.textField
            .orEmpty
            .changed
        
        return Output(nextButtonTapped: nextButtonTapped, dateTextField: textField)
    }
    
    func calculateAge(date: Date) -> Bool {
        let age: Int = -17
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = age
        let maxDate = calendar.date(byAdding: components, to: currentDate)!
        return date.dateCompare(fromDate: maxDate)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.string(from: date)
    }
}
