import Vapor
import Fluent
import FluentPostgresDriver
import NIOSSL

public func configure(_ app: Application) async throws {
    app.logger.logLevel = .debug  // Set to debug temporarily
    
    let postgresConfig = SQLPostgresConfiguration(
        hostname: Environment.get("DB_HOST") ?? "localhost",
        port: Environment.get("DB_PORT").flatMap(Int.init) ?? 5432,
        username: Environment.get("DB_USERNAME") ?? "postgres",
        password: Environment.get("DB_PASSWORD") ?? "postgres",
        database: Environment.get("DB_NAME") ?? "postgres",
        tls: .disable
    )
    
    app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    
    // Register migrations
    app.migrations.add(CreateJoke())
    
    // Register routes
    try routes(app)
}
