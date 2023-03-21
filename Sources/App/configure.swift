import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.routes.defaultMaxBodySize = "10mb"
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.workingDirectory))

    app.databases.use(.postgres(
        hostname: "localhost",
        username: "postgres",
        password: "",
        database: "diys"), as: .psql)
    
    // add migration here
    app.migrations.add(CreateUser())
    app.migrations.add(CreateDiys())
    try app.autoMigrate().wait()
    // register routes
    try routes(app)
}
