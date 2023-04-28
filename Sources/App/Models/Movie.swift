//
//  File.swift
//
//
//  Created by Tedjakusuma, Ferdinand on 27/04/23.
//

import Foundation
import Fluent
import Vapor

final class Movie: Model, Content {
    // Name of the table or collection.
    static let schema = "movies"

    // Unique identifier for this Galaxy.
    @ID(key: .id)
    var id: UUID?

    // Field's name.
    @Field(key: "title")
    var title: String
    
    @Timestamp(key: "created_at", on: .create, format: .iso8601)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update, format: .iso8601)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete, format: .iso8601)
    var deletedAt: Date?
    
    @Children(for: \.$movie)
    var reviews: [Review]

    // Constructor
    init() { }

    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
