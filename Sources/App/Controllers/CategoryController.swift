//
//  AcronymsController.swift
//  App
//
//  Created by Boocha on 22/09/2019.
//

import Foundation
import Vapor


struct CategoryController: RouteCollection {
    func boot(router: Router) throws {
        let categoryRoute = router.grouped("api", "categories")
        categoryRoute.get(use: getAllHandler)
        categoryRoute.post(Category.self, use: createHandler)
        categoryRoute.get(Category.parameter, use: getHandler)
        categoryRoute.get(Category.parameter, "acronyms", use: getAcronymsHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func createHandler(_ req: Request, Category: Category) throws -> Future<Category> {
        return Category.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
    
    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try req.parameters.next(Category.self).flatMap(to: [Acronym].self) { category in
            return try category.acronyms.query(on: req).all()
        }
    }
}
