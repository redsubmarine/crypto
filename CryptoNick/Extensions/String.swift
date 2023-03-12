//
//  String.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/12.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
