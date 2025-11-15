//
//  TriviaAPI.swift
//  TriviaGame
//
//  Created by Nakisha S. on 11/15/25.
//

import Foundation

struct TriviaAPI {
    static func fetchTrivia(amount: Int,
                            category: Int? = nil,
                            difficulty: String,
                            type: String) async throws -> [TriviaQuestion] {

        var urlString = "https://opentdb.com/api.php?amount=\(amount)&difficulty=\(difficulty)&type=\(type)"

        if let cat = category {
            urlString += "&category=\(cat)"
        }

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(TriviaResponse.self, from: data)
        return decoded.results
    }
}
