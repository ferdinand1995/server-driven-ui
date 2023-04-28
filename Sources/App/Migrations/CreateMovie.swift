//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 27/04/23.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies") // table name
            .id()
            .field("title", .string) // column name
            .create()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
}

struct AddTimestampMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .field("created_at", .string)
            .field("updated_at", .string)
            .update()
            
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
}

struct AddSoftDelete: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .field("deleted_at", .string)
            .update()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
}

struct DropColumnMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .deleteField("markAsDeleted")
            .update()
    }
    
    // undo
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies").delete() // drop the table
    }
}

