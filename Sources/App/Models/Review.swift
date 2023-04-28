//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 28/04/23.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Review: Model, Content {
    
    static let schema: String = "reviews"
    
    @ID(key: .id)
    var id: UUID? // PK
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "movie_id") // FK
    var movie: Movie
    
    @Timestamp(key: "created_at", on: .create, format: .iso8601)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update, format: .iso8601)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete, format: .iso8601)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieId
    }
}
