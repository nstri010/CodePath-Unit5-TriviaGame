//
//  TriviaQuestion.swift
//  TriviaGame
//
//  Created by Nakisha S. on 11/15/25.
//

import Foundation

struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Identifiable, Codable {
    let id = UUID()
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    let shuffledAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case question
        case correct_answer
        case incorrect_answers
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)

        // Decode raw values
        let rawQuestion = try c.decode(String.self, forKey: .question)
        let rawCorrect = try c.decode(String.self, forKey: .correct_answer)
        let rawIncorrect = try c.decode([String].self, forKey: .incorrect_answers)

        // PRE-DECODE HTML HERE (fix!)
        question = decodeHTML(rawQuestion)
        correct_answer = decodeHTML(rawCorrect)
        incorrect_answers = rawIncorrect.map { decodeHTML($0) }

        // Shuffle answers once
        shuffledAnswers = (incorrect_answers + [correct_answer]).shuffled()
    }

    // For manual testing
    init(question: String, correct: String, incorrect: [String]) {
        self.question = decodeHTML(question)
        self.correct_answer = decodeHTML(correct)
        self.incorrect_answers = incorrect.map { decodeHTML($0) }
        self.shuffledAnswers = (incorrect_answers + [correct_answer]).shuffled()
    }
}
