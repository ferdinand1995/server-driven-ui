//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 28/04/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateReview: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews") // table name
            .id()
            .field("title", .string) // column name
            .field("body", .string)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete() // drop the table
    }
}

struct AddTimestampReview: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews") // table name
            .field("created_at", .string)
            .field("updated_at", .string)
            .field("deleted_at", .string)
            .update()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews").delete() // drop the table
    }
}
