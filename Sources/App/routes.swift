import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "Call /joke to get a random joke"
    }

    app.get("joke") { req async throws -> JokeResponse in
        guard let joke = try await Joke.query(on: req.db).all().randomElement() else {
            throw Abort(.notFound, reason: "No jokes found")
        }
        return JokeResponse(joke: joke)
    }

    app.post("***REMOVED***") { req async throws -> JokeResponse in
        let joke = try req.content.decode(Joke.self)
        try await joke.save(on: req.db)
        return JokeResponse(joke: joke)
    }
}