//
//  WebsiteController.swift
//  App
//
//  Created by Boocha on 27/09/2019.
//

import Foundation
import Vapor

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        let context = IndexContent(title: "home")
        return try req.view().render("index", context)
    }
}

struct IndexContent: Encodable{
    let title: String
}
