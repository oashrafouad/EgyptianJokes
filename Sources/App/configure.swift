import Fluent
import FluentPostgresDriver
import Vapor

public func configure(_ app: Application) async throws {
    if app.environment == .production {
        app.logger.logLevel = .warning
    } else {
        app.logger.logLevel = .debug
    }

    let postgresConfig = SQLPostgresConfiguration(
        hostname: Environment.get("DB_HOST") ?? "localhost",
        port: Environment.get("DB_PORT").flatMap(Int.init) ?? 5432,
        username: Environment.get("DB_USERNAME") ?? "postgres",
        password: Environment.get("DB_PASSWORD") ?? "postgres",
        database: Environment.get("DB_NAME") ?? "postgres",
        tls: .disable
    )

    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)

    app.migrations.add(CreateJoke())

    try routes(app)
}
