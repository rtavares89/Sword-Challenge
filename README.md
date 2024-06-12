# Sword-Challenge

## Description
This is my approach to Sword challenge, I hope that this meets your standards. I tried to focus my time on providing what I believe is a good architecture to this challenge. Due to this prioritisation, I didn't have time to add any UI tests nor components tests. Although I studied TCA recently, I didn't feel comfortable to do the entire challenge using it so for that reason, I decided to use SwiftUI + MVVM. Also on the offline functionality, I only persisted the favourite cats so that those keep in memory on every app launch. I also would have liked to have time to do some refactors on UI side so that I can reuse some UI elements. It was my first time using SwiftData, I would like to have it more generic instead of just for FavouriteCatsModel class.

## Requirements
- iOS 17.5
- Xcode 15.4

## Architecture
- MVVM (Presentation Layer)
- Clean Architecture 

## Modules
- Core: Responsible for the application business rules.
- Data: Responsible for fetching data
    - Gateway: fetch data from remote cats api;
    - Repository: fetch data from local persistence;
- Sword Challenge App: Presentation Layer (MVVM).

## Third Parties

None. This was a decision I made so that I can have control of the code. I believe that adding external dependencies should be well thought because we are basically losing control of part of the application code. 

## Testing Strategy
- TDD and BDD for testing using the pattern "GIVEN...WHEN...THEN..."

## TODO
- Error Handling: The errors are thrown until the ViewModel but they are not shown to user.
- UI tests
- Components tests
