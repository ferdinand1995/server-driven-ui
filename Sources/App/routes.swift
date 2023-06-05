import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: APIController())
    try app.register(collection: MovieController())
    try app.register(collection: UIHomeController())
}
