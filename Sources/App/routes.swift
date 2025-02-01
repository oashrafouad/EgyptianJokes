import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Call /joke to get a random joke"
    }

    app.get("joke") { req async throws -> Joke in
        guard let joke = try await Joke.query(on: req.db).all().randomElement() else {
            throw Abort(.notFound, reason: "No jokes found")
        }
        return joke
    }

    app.post("***REMOVED***") { req async throws -> Joke in
        let joke = try req.content.decode(Joke.self)
        try await joke.save(on: req.db)
        return joke
    }

    // app.get("db-test") { req async throws -> String in
    //     let user = User(name: "Omar")
    //     try await user.save(on: req.db)
    //     return "Database connection works!"
    // }
}