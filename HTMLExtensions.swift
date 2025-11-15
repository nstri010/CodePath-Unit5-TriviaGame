//
//  HTMLEx.swift
//  TriviaGame
//
//  Created by Nakisha S. on 11/15/25.
//

import Foundation

func decodeHTML(_ text: String) -> String {
    guard let data = text.data(using: .utf8) else { return text }
    if let attributed = try? NSAttributedString(
        data: data,
        options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ],
        documentAttributes: nil
    ) {
        return attributed.string
    }
    return text
}
