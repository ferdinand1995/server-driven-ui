//
//  UIHomeController.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 31/05/23.
//

import Foundation
import Vapor

struct UIHomeController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("ui")
        api.get(use: getHomeContent)
        // GET /ui-home
        api.get("home", use: getHomeContent)


        // PUT /movies
        api.put { req -> EventLoopFuture<HTTPStatus> in
            let movie = try decodeMovie(req)
            return Movie.find(movie.id, on: req.db).unwrap(or: Abort(.notFound)).flatMap({
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
            })
        }

        // POST /reviews
        api.post("reviews") { (req: Request) -> EventLoopFuture<Review> in
            let review = try req.content.decode(Review.self)
            return review.create(on: req.db).map { review }
        }
    }

    private func decodeMovie(_ req: Request) throws -> Movie {
        return try req.content.decode(Movie.self)
    }

    private func getHomeContent(_ req: Request) throws -> Presentation {
        let componentData = ComponentData(imageURL: "https://images.unsplash.com/photo-1517331156700-3c241d2b4d83?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1468&q=80%22", url: nil)
        let component = Component(type: "componentScreen", title: "Home", data: [componentData], action: ComponentAction(type: "image", url: nil))
        let presentation = Presentation(version: "1.0", body: [component])
        return presentation
    }
}
