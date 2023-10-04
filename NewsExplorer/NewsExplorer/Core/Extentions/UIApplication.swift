//
//  UIApplication.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, 
                   from: nil,
                   for: nil)
    }
}
