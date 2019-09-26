//
//  AcronymsController.swift
//  App
//
//  Created by Boocha on 22/09/2019.
//

import Foundation
import Vapor


struct UserController: RouteCollection {
    func boot(router: Router) throws {
        let userRoure = router.grouped("api", "user")
        userRoure.get(use: getAllHandler)
        userRoure.post(User.self, use: createHandler)
        userRoure.get(User.parameter, use: getHandler)
        userRoure.get(User.parameter, "acronyms", use: getAcronymsHandler)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func createHandler(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try req.parameters.next(User.self).flatMap(to: [Acronym].self) { user in
            return try user.acronyms.query(on: req).all()
        }
    }
    
}
