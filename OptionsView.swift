//
//  OptionsView.swift
//  TriviaGame
//
//  Created by Nakisha S. on 11/15/25.
//

import SwiftUI

struct OptionsView: View {

    // ----- CATEGORY LIST -----
    let categories: [(name: String, id: Int?)] = [
        ("Random", nil),
        ("General Knowledge", 9),
        ("Entertainment: Books", 10),
        ("Entertainment: Film", 11),
        ("Entertainment: Music", 12),
        ("Entertainment: Musicals & Theatre", 13),
        ("Entertainment: Television", 14),
        ("Entertainment: Video Games", 15),
        ("Entertainment: Board Games", 16),
        ("Science & Nature", 17),
        ("Science: Computers", 18),
        ("Science: Mathematics", 19),
        ("Mythology", 20),
        ("Sports", 21),
        ("Geography", 22),
        ("History", 23),
        ("Politics", 24),
        ("Art", 25),
        ("Celebrities", 26),
        ("Animals", 27),
        ("Vehicles", 28),
        ("Entertainment: Comics", 29),
        ("Science: Gadgets", 30),
        ("Anime & Manga", 31),
        ("Cartoons & Animations", 32)
    ]

    // ----- STATE -----
    @State private var selectedCategoryIndex = 0
    @State private var numQuestions = 5
    @State private var difficulty = "easy"
    @State private var type = "multiple"   // <---- ADDED BACK!

    @State private var questions: [TriviaQuestion] = []
    @State private var navigateToGame = false

    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            Form {

                // ----- SETTINGS -----
                Section(header: Text("Question Settings")) {

                    Stepper("Number of Questions: \(numQuestions)",
                            value: $numQuestions,
                            in: 1...20)

                    // ---------- TYPE PICKER (NEW, AFTER QUESTIONS) ----------
                    Picker("Type", selection: $type) {
                        Text("Multiple Choice").tag("multiple")
                        Text("True / False").tag("boolean")
                    }

                    Picker("Difficulty", selection: $difficulty) {
                        Text("Easy").tag("easy")
                        Text("Medium").tag("medium")
                        Text("Hard").tag("hard")
                    }

                    Picker("Category", selection: $selectedCategoryIndex) {
                        ForEach(0..<categories.count, id: \.self) { i in
                            Text(categories[i].name).tag(i)
                        }
                    }
                }

                // ----- START BUTTON -----
                Section {
                    Button("Start Quiz") {
                        loadTrivia()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Trivia Options")
            .navigationDestination(isPresented: $navigateToGame) {
                TriviaGameView(questions: questions)
            }
            .alert("Error", isPresented: .constant(errorMessage != nil)) {
                Button("OK") { errorMessage = nil }
            } message: {
                Text(errorMessage ?? "Unknown error")
            }
        }
    }

    // ----- LOAD QUESTIONS FROM API -----
    private func loadTrivia() {
        let categoryID = categories[selectedCategoryIndex].id

        Task {
            do {
                let fetched = try await TriviaAPI.fetchTrivia(
                    amount: numQuestions,
                    category: categoryID,
                    difficulty: difficulty,
                    type: type        // <---- IMPORTANT
                )

                questions = fetched
                navigateToGame = true

            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
