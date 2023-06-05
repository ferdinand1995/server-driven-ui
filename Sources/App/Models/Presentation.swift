//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 31/05/23.
//

import Foundation
import Vapor

struct Presentation: Content {
    let version: String?
    let body: [Component]?
}

struct Component: Content {
    let type: String
    let title: String
    let data: [ComponentData]
    let action: ComponentAction
}

struct ComponentData: Content {
    let imageURL: String?
    let url: String?
}

struct ComponentAction: Content {
    let type: String
    let url: String?
}
