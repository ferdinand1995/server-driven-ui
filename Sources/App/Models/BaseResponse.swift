//
//  File.swift
//  
//
//  Created by Tedjakusuma, Ferdinand on 28/04/23.
//

import Foundation
import Fluent
import Vapor

struct BaseResponse: Content {
    var dateTime: String?
    var statusCode: Int
}
