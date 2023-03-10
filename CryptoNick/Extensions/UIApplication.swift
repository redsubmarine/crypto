//
//  UIApplication.swift
//  CryptoNick
//
//  Created by 레드 on 2023/03/10.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
