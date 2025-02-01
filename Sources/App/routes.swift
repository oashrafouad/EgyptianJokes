import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.post("***REMOVED***") { req async throws -> Joke in
        let joke = try req.content.decode(Joke.self)
        try await joke.save(on: req.db)
        return joke
    }

    app.get("db-test") { req async throws -> String in
        let user = User(name: "Omar")
        try await user.save(on: req.db)
        return "Database connection works!"
    }
}