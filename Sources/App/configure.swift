import Vapor
import Fluent
import FluentPostgresDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    /// database's credentials
     app.databases.use(.postgres(hostname: "db.sqohrendzvxcmwqzjyfw.supabase.co", username: "postgres", password: "CAQCDuiPWLG5wOIc", database: "postgres"), as: .psql)
    app.migrations.add(CreateMovie())
    app.migrations.add(CreateReview())
    app.migrations.add(AddTimestampReview())
    app.logger.logLevel = .debug
    /// register routes
    try routes(app)
}
