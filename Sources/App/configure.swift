import Vapor
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) async throws {
    // Set log level to debug
    app.logger.logLevel = .debug

    // Database configuration
    let postgresConfig = SQLPostgresConfiguration(
        hostname: "localhost",
        port: SQLPostgresConfiguration.ianaPortNumber,
        username: "omar",
        password: "mypassword",
        database: "postgres",
        tls: .disable
    )
    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)

    // Register migrations
    app.migrations.add(CreateUser())

    // Register routes
    try routes(app)
}
