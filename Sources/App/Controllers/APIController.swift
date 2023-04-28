//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 27/04/23.
//

import Foundation
import Vapor

struct User: Content {
    let name: String
    let age: Int
    let address: Address?
}

struct Address: Content {
    let street: String
    let state: String
    let zipCode: String
}

struct APIController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        api.get("users", use: getUsers)
    }
    
    private func getUsers(req: Request) throws -> [User] {
        let addressUser1 = Address(street: "1200 Richmond Ave", state: "TX", zipCode: "77098")
        let user1 = User(name: "John Doe", age: 18, address: addressUser1)
        let user2 = User(name: "Don Jon", age: 20, address: nil)
        return [user1, user2]
    }
}
