//
//  TriviaGameView.swift
//  TriviaGame
//
//  Created by Nakisha S. on 11/15/25.
//

import SwiftUI

struct TriviaGameView: View {
    let questions: [TriviaQuestion]

    
    @State private var currentIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var score = 0
    @State private var showAnswers = false
    @State private var showScoreAlert = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {

            if currentIndex < questions.count {
                let question = questions[currentIndex]

                // ❌ remove decodeHTML from here
                // Text(decodeHTML(question.question))

                // ✅ use the already-decoded model value
                Text(question.question)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()

                // ------- ANSWER BUTTONS -------
                VStack(spacing: 12) {
                    ForEach(question.shuffledAnswers, id: \.self) { answer in

                        Button {
                            print("Tapped:", answer)   // DEBUG PRINT
                            if !showAnswers {
                                selectedAnswer = answer
                            }
                        } label: {
                            HStack {
                                // ❌ remove decodeHTML here too
                                // Text(decodeHTML(answer))

                                // ✅ use already-decoded answer
                                Text(answer)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                if showAnswers {
                                    if answer == question.correct_answer {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    } else if answer == selectedAnswer {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding()
                            .background(buttonColor(for: answer,
                                                   correctAnswer: question.correct_answer))
                            .cornerRadius(12)
                        }
                        .disabled(showAnswers)
                    }
                }

                // -------- SUBMIT / NEXT --------
                Button {
                    if showAnswers {
                        nextQuestion()
                    } else {
                        checkAnswer(correct: question.correct_answer)
                    }
                } label: {
                    Text(showAnswers ? "Next Question" : "Submit Answer")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(selectedAnswer == nil)
                .padding(.top)
            }
        }
        .padding()
        .alert("Quiz Complete!", isPresented: $showScoreAlert) {
            Button("Play Again") { restartGame() }
            Button("Main Menu", role: .cancel) { dismiss() }
        } message: {
            VStack(alignment: .leading, spacing: 6) {
                Text("Score: \(score)/\(questions.count)")
            }
        }
    }

    // -------------------------------------
    // MARK: - GAME LOGIC
    // -------------------------------------

    private func checkAnswer(correct: String) {
        if selectedAnswer == correct { score += 1 }
        showAnswers = true
    }

    private func nextQuestion() {
        selectedAnswer = nil
        showAnswers = false

        if currentIndex < questions.count - 1 {
            currentIndex += 1
        } else {
            showScoreAlert = true
        }
    }

    private func restartGame() {
        score = 0
        currentIndex = 0
        selectedAnswer = nil
        showAnswers = false
    }

    private func buttonColor(for answer: String, correctAnswer: String) -> Color {
        if showAnswers {
            if answer == correctAnswer { return Color.green.opacity(0.3) }
            if answer == selectedAnswer { return Color.red.opacity(0.3) }
        } else if answer == selectedAnswer {
            return Color.blue.opacity(0.2)
        }
        return Color.gray.opacity(0.15)
    }
}
