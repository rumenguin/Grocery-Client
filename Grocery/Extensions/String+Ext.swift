//
//  String+Ext.swift
//  Grocery
//
//  Created by RUMEN GUIN on 23/05/23.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
