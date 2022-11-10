//
//  RegexVaidation.swift
//  SeSAC_StudyMatchingApp
//
//  Created by Seokjune Hong on 2022/11/08.
//

import Foundation

enum RegexValidation: String {
    case phoneNumber = "^01[0|1]-?([0-9]{3,4})-?([0-9]{4})"
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}
