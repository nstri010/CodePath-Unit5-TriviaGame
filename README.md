# Project 5 - Trivia Game

Submitted by: Nakish Strickland

Swift Trivia Game is an app that allows users to customize and play a trivia quiz using questions from the Open Trivia Database API. Users can select the number of questions, category, difficulty, and question type before starting the game. The app displays multiple-choice or true/false questions and allows users to select and submit answers, then view their overall score.

Time spent: 3 hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App launches to an Options screen where user can modify the types of questions presented when the game starts. Users should be able to choose:
  - [x] Number of questions
  - [x] Category of questions
  - [x] Difficulty of questions
  - [x] Type of questions (Multiple Choice or True False)
- [x] User can tap a button to start trivia game, this presents questions and answers in a List or Card view.
  - Hint: For Card view visit your FlashCard app. List view is an equivalent to UITableView in UIKit. Much easier to use!
- [x] Selected choices are marked as user taps their choice (but answered is not presented yet!)
- [x] User can submit choices and is presented with a score on trivia game
 
The following **optional** features are implemented:

- [x] User has answer marked as correct or incorrect after submitting choices.
- [ ] Implement a timer that puts pressure on the user! Choose any time that works and auto submit choices after the timer expires. 

The following **additional** features are implemented:

- [x] HTML decoding added so trivia questions and answers display cleanly without encoded characters such as &quot; or &#039;.
- [x] Clean card-style UI for questions and answer choices.
 - [x] Organized Options screen using Form, Picker, and Stepper components.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Here is a reminder on how to embed Loom videos on GitHub. Feel free to remove this reminder once you upload your README. 

Loom Video: https://www.loom.com/share/563294bac2604023b5dd421fa0020b0f

## Notes

During development, one of the main challenges was handling the answer-selection logic.
SwiftUI’s state updates were being interrupted when the timer was active, causing answer buttons to stop selecting or highlighting properly. After extensive debugging, the root issue was narrowed down to state conflicts triggered by the countdown timer’s frequent updates. To ensure smooth gameplay, the timer feature was removed and the app now works consistently.

Another challenge involved decoding HTML entities returned by the Open Trivia API (such as &amp;, &#039;, etc.). Creating a small HTML decoding helper resolved this and improved readability.

## License

    Copyright 2025 Codepath.org

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
