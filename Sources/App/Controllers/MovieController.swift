//
//  File.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 27/04/23.
//

import Foundation
import Vapor

struct MovieController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("movies")
        // POST /movies
        api.post { req -> EventLoopFuture<Movie> in
            let movie = try decodeMovie(req)
            return movie.create(on: req.db).map({ movie })
        }
        // GET /movies
        api.get { req in
            Movie.query(on: req.db).with(\.$reviews).all()
        }
        // GET /movies include soft delete object
        api.get("deleted") { req in
            Movie.query(on: req.db).withDeleted().all()
        }
        
        // GET /movies/:movieId
        api.get(":movieId") { req -> EventLoopFuture<Movie> in
            Movie.find(req.parameters.get("movieId"), on: req.db).unwrap(or: Abort(.notFound))
        }
        // PUT /movies
        api.put { req -> EventLoopFuture<HTTPStatus> in
            let movie = try decodeMovie(req)
            return Movie.find(movie.id, on: req.db).unwrap(or: Abort(.notFound)).flatMap({
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
            })
        }
        // DELETE /movies/:movieId
        // soft delete
        api.delete(":movieId") { req -> EventLoopFuture<HTTPStatus> in
            Movie.find(req.parameters.get("movieId"), on: req.db).unwrap(or: Abort(.notFound)).flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
        }
        
        api.post("reviews") { (req: Request) -> EventLoopFuture<Review> in
            let review = try req.content.decode(Review.self)
            return review.create(on: req.db).map { review }
        }
    }

    private func decodeMovie(_ req: Request) throws -> Movie {
        return try req.content.decode(Movie.self)
    }
}
