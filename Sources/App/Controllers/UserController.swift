//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import Vapor

//MARK: Controller: carry out the CRUD operations, by using a set of HTTP verbs to make server requests.
struct UserController: RouteCollection {
    
    //MARK: here we crete the endpoints
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.post(use: create)
        
        //routes.get(":id",use: getHandler)
        
      //  GET All of The User's DIYs
        routes.get(":id","project", use: getDIYsHandler)
        
        
        
        let singleUserRoutes = routes.grouped(":id")
        
        //Get One User by ID
        singleUserRoutes.get(use: getHandler)
    
        singleUserRoutes.delete(use: delete)
        singleUserRoutes.put(use: update)
        
        singleUserRoutes.post("image", use: uploadImage)
        singleUserRoutes.put("image", use: uploadImage)
    }
    
    //MARK: basic CRUD
    //Endpoint 1: return a list of all user
    func index(req: Request)  throws -> EventLoopFuture<[User]> {
        return User.query(on: req.db).all()
    }
    
    //Endpoint 2: create a new user
    func create(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db).map{user}
    }
    
    
    //To Get One User By ID
    func getHandler(_ req: Request) -> EventLoopFuture<User> {
        User.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    //Get The All of The User's DIYs
    func getDIYsHandler(_ req: Request) -> EventLoopFuture<[Diy]> {
        User.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.$projects.get(on: req.db)
            }
    }
    
    
    
    //Endpoint 3: delete a user
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let uuid = req.parameters.get("id", as: UUID.self)
        return User
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
            .flatMap { user in
                user.delete(on: req.db)
            }
            .transform(to: .ok)
    }
    
    //Endpoint 4: update a user
    func update(req: Request) throws -> EventLoopFuture<User> {
        let input = try req.content.decode(User.self)
        let uuid = req.parameters.get("id", as: UUID.self)
        return User
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
            .flatMap { user in
                user.firstName = input.firstName
                user.lastName = input.lastName
                user.socialMedia = input.socialMedia
                user.picture = input.picture
                return user.save(on: req.db).map{user}
            }
    }
    
    //Endpoint 5: uploadImage for a user
    private func uploadImage(req: Request) throws -> EventLoopFuture<Response> {
        
        let uuid = req.parameters.get("id", as: UUID.self)
        let file = try req.content.decode(File.self) //the json body should be file
        let path = req.application.directory.workingDirectory + file.filename
        
        //1. Fetching the list and aborting if notFound
        return User
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
        //2. Save the file into a path
            .flatMap { user in // flatMap used here since writeFile return Future
                req.fileio
                    .writeFile(file.data, at: path)
                    .map {user} // map used here since it returns a type that is not a Future -> it will return that particular planet
            }
        //3. Update the planet with the updated data
            .flatMap { user in
                let hostname = req.application.http.server.configuration.hostname
                let port = req.application.http.server.configuration.port
                user.picture = "\(hostname):\(port)/\(file.filename)"
        //4. Return the updated planet as a response
                return user
                    .update(on: req.db)
                    .map {user}
                    .encodeResponse(status: .accepted, for: req)
            }
    }
    
    /*
     func show(req: Request) async throws -> User {
        
    }
     */
}
