import Vapor
import Fluent

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("example") { req async -> String in
        "This is an example"
    }

    app.get("db-test") { req async throws -> String in
        let user = User(name: "Test User 2")
        try await user.save(on: req.db)
        return "Database connection works!"
    }
}