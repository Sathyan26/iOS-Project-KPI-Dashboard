/*:
 # CSCI 321/521 Assignment 2
 ## Part B: Swift Mastery Exercises
 
 Complete each exercise below. Your code should compile and run without errors.
 
 **Student Name: Alexander Cumbo
 **Z-ID: z1964909
 **Partner Name (if applicable): Satyhan Asokan Geethpriya
 **Partner Z-ID (if applicable): z1976271
 
 ---
 */

import Foundation

/*:
 ## Exercise 1: Error Handling (15 points)
 
 ### 1a) ValidationError Enum
 Create an enum `ValidationError` that conforms to `Error` with the following cases:
 - `emptyField(fieldName: String)`
 - `invalidFormat(fieldName: String)`
 - `valueTooLong(fieldName: String, maxLength: Int)`
 */

// Your code for 1a here:
enum ValidationError: Error {
    case emptyField(fieldName: String)
    case invalidFormat(fieldName: String)
    case valueTooLong(fieldName: String, maxLength: Int)
}

/*:
 ### 1b) Validate Username Function
 Write a function `validateUsername(_ username: String?) throws -> String` that:
 - Throws `emptyField` if username is nil or empty
 - Throws `invalidFormat` if username contains non-alphanumeric characters
 - Throws `valueTooLong` if username length > 20
 - Returns the valid username if all checks pass
 
 **Hint:** You can use `CharacterSet.alphanumerics` to check for valid characters.
 */

// Your code for 1b here:

func validateUsername(_ username: String?) throws -> String {
    let fieldName = "Username"
    
    guard let username = username else {
        throw ValidationError.emptyField(fieldName: fieldName)
    }
    
    let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else {
        throw ValidationError.emptyField(fieldName: fieldName)
    }
    
    // Only allow letters, numbers, underscore
    let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_"))
    if trimmed.unicodeScalars.contains(where: { !allowedCharacters.contains($0) }) {
        throw ValidationError.invalidFormat(fieldName: fieldName)
    }
    
    let maxLength = 20
    if trimmed.count > maxLength {
        throw ValidationError.valueTooLong(fieldName: fieldName, maxLength: maxLength)
    }
    
    return trimmed
}


/*:
 ### 1c) Calling the Validation Function
 Demonstrate calling your validation function with:
 1. `do-catch` - handle different error cases
 2. `try?` - convert to optional
 3. `try!` - force try (use a value you KNOW is safe)
 */

// Your code for 1c here:

let testValues: [String?] = [nil, "", "valid_user_123", "invalid user", String(repeating: "a", count: 25)]

// Using do-catch:

for value in testValues {
        do {
            let result = try validateUsername(value)
            print("Valid username: \(result)")
        } catch let error as ValidationError {
            switch error {
            case .emptyField(let fieldName):
                print("Error: \(fieldName) is empty")
            case .invalidFormat(let fieldName):
                print("Error: \(fieldName) has invalid format")
            case .valueTooLong(let fieldName, let maxLength):
                print("Error: \(fieldName) is longer than \(maxLength) characters")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }

// Using try?:

let maybeUsername = try? validateUsername("optional_user")
print("Result of try?: \(String(describing: maybeUsername))")

// Using try! (with a safe value):

let guaranteedValid = try! validateUsername("safeUserName")
    print("Result of try!: \(guaranteedValid)")
/*:
 ### 1d) When to Use Each Approach
 Write a comment explaining when you would use each approach: `do-catch` vs `try?` vs `try!`
 */

/*
 Your explanation for 1d here:
 
do-catch: Use when you need to handle specific errors and possibly recover (e.g., show different messages for empty vs invalid input).
 
 
try?: Use when you only care if the operation succeeds or fails and are fine with getting nil on failure instead of detailed error information.
 

try!: Use only when you are certain an error will never occur (for example, hard-coded values in tests). If an error does occur, the app will crash.
 
 
 */


/*:
 ---
 ## Exercise 2: Protocols (15 points)
 
 ### 2e) Displayable Protocol
 Create a protocol `Displayable` with the following requirements:
 - `var title: String { get }`
 - `var subtitle: String { get }`
 - `func formattedDescription() -> String`
 */

// Your code for 2e here:

protocol Displayable {
    var title: String { get }
    var subtitle: String { get }
    func formattedDescription() -> String
}


/*:
 ### 2f) Conform Your Primary Model
 Copy your primary model from Part A (or create a simplified version) and make it conform to `Displayable`.
 
 **Note:** If you haven't completed Part A yet, create a simple model like `Book` or `Task` with a few properties.
 */

// Your code for 2f here:


enum TransactionType {
    case sale
    case expense
}

enum CategoryType: String, CaseIterable {
    case food
    case retail
    case marketing
    case utilities
    case services
}

enum SalesChannel: String {
    case online
    case inStore
}

struct Transaction: Displayable {
    
    var title: String {
        type == .sale ? "Sale" : "Expense"
    }
    
    var subtitle: String {
        let amountString = String(format: "$%.2f", amount)
        let dateString = DateFormatter.localizedString(
            from: date,
            dateStyle: .short,
            timeStyle: .none
        )
        return "\(amountString) . \(dateString)"
    }
    
    func formattedDescription() -> String {
        var components = [String]()
        components.append(title)
        components.append(subtitle)
        components.append(category.rawValue.capitalized)
        components.append(channel.rawValue.capitalized)
        if let note = note {
            components.append(note)
        }
        return components.joined(separator: " . ")
    }
    
    let id: UUID
    let type: TransactionType
    let amount: Double
    let date: Date
    let category: CategoryType
    let channel: SalesChannel
    var note: String? = nil
    var isRevenue: Bool {
        return type == .sale
    }
}



/*:
 ### 2g) Second Conforming Type
 Create a second, unrelated struct (e.g., `Event`, `Product`, `Contact`) that also conforms to `Displayable`.
 */

// Your code for 2g here:

struct Event: Displayable {
    let name: String
    let date: Date
    let location: String
    
    var title: String {
        name
    }
    
    var subtitle: String {
        "Location: \(location)"
    }
    
    func formattedDescription() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        return """
        Event: \(name)
        When: \(formatter.string(from: date))
        Where: \(location)
        """
    }
}



/*:
 ### 2h) Print Info Function
 Write a function `printInfo(for item: Displayable)` that prints the formatted description.
 */

// Your code for 2h here:

func printInfo(for item: Displayable) {
    print("Title: \(item.title)")
    print("Subtitle: \(item.subtitle)")
    print(item.formattedDescription())
    print("----------")
}


/*:
 ### 2i) Demonstrate Protocol Usage
 Demonstrate calling `printInfo` with instances of both conforming types.
 */

// Your code for 2i here:
extension Transaction {
    static let transaction: [Transaction] = [
        Transaction(
            id: UUID(),
            type: .sale,
            amount: 120.50,
            date: Date(),
            category: .retail,
            channel: .online,
            note: "Order #1001"
        )
    ]
}

extension Event {
    static let event: [Event] = [
        Event(
            name: "iOS Dev Meetup",
            date: Date(),
            location: "DeKalb, IL"
        )
    ]
}

/*
let event = Event(
        name: "iOS Dev Meetup",
        date: Date(),
        location: "DeKalb, IL"
    )
 */
printInfo(for: Transaction.transaction[0])
printInfo(for: Event.event[0])


/*:
 ---
 ## Exercise 3: Generics (10 points)
 
 ### 3j) Generic findFirst Function
 Write a generic function:
 ```
 findFirst<T: Equatable>(in array: [T], where predicate: (T) -> Bool) -> T?
 ```
 that returns the first element matching the predicate.
 */

// Your code for 3j here:

func findFirst<T: Equatable>(in array: [T], where predicate: (T) -> Bool) -> T? {
    for element in array {
        if predicate(element) {
            return element
        }
    }
    return nil
}


/*:
 ### 3k) Demonstrate findFirst Usage
 Demonstrate using your `findFirst` function with:
 1. An array of `String`s
 2. An array of `Int`s
 */

// Your code for 3k here:

// With Strings:

let names = ["Alice", "Bob", "Charlie", "David"]
    let firstWithC = findFirst(in: names) { $0.hasPrefix("C") }
    print("First name starting with C: \(String(describing: firstWithC))")

// With Ints:
let numbers = [3, 8, 15, 16, 23, 42]
    let firstGreaterThan20 = findFirst(in: numbers) { $0 > 20 }
    print("First number greater than 20: \(String(describing: firstGreaterThan20))")


/*:
 ### 3l) Generic Stack
 Write a generic struct `Stack<Element>` with the following methods:
 - `mutating func push(_ element: Element)`
 - `mutating func pop() -> Element?`
 - `func peek() -> Element?`
 - `var isEmpty: Bool { get }`
 
 Demonstrate its usage with at least one type.
 */

// Your code for 3l here:

struct Stack<Element> {
    private var storage: [Element] = []
    
    mutating func push(_ value: Element) {
        storage.append(value)
    }
    
    @discardableResult
    mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    func peek() -> Element? {
        return storage.last
    }
    
    var isEmpty: Bool {
        storage.isEmpty
    }
}


// Demonstrate usage:
print("=== Stack of Ints ===")
var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
intStack.push(30)
print("Top element: \(String(describing: intStack.peek()))")
print("Popped: \(String(describing: intStack.pop()))")
print("Top after pop: \(String(describing: intStack.peek()))")

print("\n=== Stack of Strings ===")
var stringStack = Stack<String>()
stringStack.push("First")
stringStack.push("Second")
print("Top element: \(String(describing: stringStack.peek()))")




/*:
 ---
 ## Exercise 4: Type Casting (10 points)
 
 ### 4m) Class Hierarchy
 Create a class hierarchy:
 - Base class `MediaItem` with a `title: String` property
 - Subclass `Movie` with a `director: String` property
 - Subclass `Song` with an `artist: String` property
 
 Include appropriate initializers for each class.
 */

// Your code for 4m here:

class MediaItem {
    let title: String
    
    init(title: String) {
        self.title = title
    }
}

class Movie: MediaItem {
    let director: String
    let durationMinutes: Int
    
    init(title: String, director: String, durationMinutes: Int) {
        self.director = director
        self.durationMinutes = durationMinutes
        super.init(title: title)
    }
}

class Song: MediaItem {
    let artist: String
    let lengthSeconds: Int
    
    init(title: String, artist: String, lengthSeconds: Int) {
        self.artist = artist
        self.lengthSeconds = lengthSeconds
        super.init(title: title)
    }
}



/*:
 ### 4n) Mixed Array
 Create an array of `MediaItem` containing a mix of `Movie` and `Song` instances (at least 5 items total).
 */

// Your code for 4n here:

let library: [MediaItem] = [
    Movie(title: "Inception", director: "Christopher Nolan", durationMinutes: 148),
    Song(title: "Imagine", artist: "John Lennon", lengthSeconds: 183),
    Movie(title: "The Matrix", director: "The Wachowskis", durationMinutes: 136),
    Song(title: "Bohemian Rhapsody", artist: "Queen", lengthSeconds: 354)
]


/*:
 ### 4o) Count with `is`
 Use a `for` loop with `is` to count how many movies and songs are in the array.
 Print the counts.
 */

// Your code for 4o here:

func countMediaItems(in items: [MediaItem]) {
    var movieCount = 0
    var songCount = 0
    
    for item in items {
        if item is Movie {
            movieCount += 1
        } else if item is Song {
            songCount += 1
        }
    }
    
    print("Movies: \(movieCount), Songs: \(songCount)")
}


/*:
 ### 4p) Downcast with `as?`
 Use `as?` to safely downcast items and print movie-specific or song-specific information.
 */

// Your code for 4p here:

// Your code for 4p here:

for item in library {
    if let movie = item as? Movie {
        print("Movie: '\(movie.title)', Directed by: \(movie.director) (\(movie.durationMinutes) mins)")
    } else if let song = item as? Song {
        print("Song: '\(song.title)', Artist: \(song.artist) (\(song.lengthSeconds) seconds)")
    }
}



/*:
 ---
 ## 🎉 Congratulations!
 
 You've completed the Swift Mastery exercises. Make sure to:
 1. Review your code for any errors
 2. Add comments where helpful
 3. Ensure everything compiles and runs
 
 OPTIONAL IF USING GIT:
 4. Commit your work to Git (minimum 3 commits)
 5. Create your Pull Request
 */
