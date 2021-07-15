//
//  String+.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/06.
//

import Foundation

extension String {
    func isWidthLongerThanHeight() -> Bool {
        let sizeStr = self.split(separator: "/").last
        guard let sizeString = sizeStr else { return false }
        let widthHeight = sizeString.components(separatedBy: CharacterSet.decimalDigits.inverted).flatMap { Int($0) }
        
        if widthHeight.count < 2 {
            return false
        }

        return widthHeight[0] > widthHeight[1]
    }
    
    func relativeTime(in locale: Locale = .current, unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full) -> String {
        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: self) else { return "" }
        
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.unitsStyle = unitsStyle

        return formatter.localizedString(for: releaseDate, relativeTo: Date())
     }
}
