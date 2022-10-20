//
//  Extension+Date.swift
//  MarvelHeroes
//
//  Created by Krystyna Kruchkovska on 20/10/2022.
//

import Foundation

extension String {
    var yyyyMMddFormatDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.date(from: self)
    }
}
