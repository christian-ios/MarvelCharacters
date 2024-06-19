#Marvel Characters App
###Description
The Marvel Characters App lets you browse and explore a list of Marvel characters. You can see character details and view all comics for a selected character. The app uses the Marvel API (https://developer.marvel.com/) to fetch character and comic data. It is built and tested for tvOS.

#Setting API Key Token
To use the Marvel API, follow these steps:
###Locate the API configuration file:
Open Constants.swift.
###Set your API key:
Replace the placeholder with your actual Marvel API key and private key:
struct Constants {
    static let apiKey = "Key"
    static let privateKey = "PrivateKey"
}
###Save the file:
Save the file and rebuild the project.

#Architecture
The app follows Clean Architecture principles for better separation of concerns and testability:

Presentation Layer: SwiftUI views and view models.
Domain Layer: Business logic and use cases.
Data Layer: Network data and repositories.


#Features and Implementation
###Character Layout:
Displays a horizontal scrollable list of Marvel characters with images and names.
###Character Details and Comics List:
When a character is selected, it shows a list of comics related to that character.
###Pagination:
Characters: Automatically loads more characters when you scroll to the end.
Comics: Loads more comics for a character when you scroll to the end.z

#Tests:
###Unit Tests:
Located in MarvelCharactersTests, covering ViewModels and UseCases.
###UI Tests:
Located in MarvelCharactersUITests, validating the user interface.

#Requirements
###No Third-Party Frameworks:
The app is built using only standard Swift and SwiftUI libraries.
###Combine and Async/Await:
Uses Combine with @Published properties for state management and reactive programming.
Uses async/await for clean and modern asynchronous network requests.
###SwiftUI for UI:
Entire UI is built with SwiftUI, following best practices for responsive and dynamic views.
