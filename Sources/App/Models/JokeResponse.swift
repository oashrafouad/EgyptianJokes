import Vapor

struct JokeResponse: Content {
    let content: String
    
    init(joke: Joke) {
        self.content = joke.content
    }
}