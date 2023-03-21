//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import Vapor

struct DiyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
        routes.post(use: create)
        
    
        let singleDiyRoutes = routes.grouped(":id")
        
        //Get diy by ID
        singleDiyRoutes.get(use: getHandler)
        
        singleDiyRoutes.delete(use: delete)
        singleDiyRoutes.put(use: update)
        

       
        singleDiyRoutes.post("image", use: uploadImage)
        singleDiyRoutes.put("image", use: uploadImage)
        
        singleDiyRoutes.post("video", use: uploadVideo)
        singleDiyRoutes.put("video", use: uploadVideo)
    }
    
    //MARK: basic CRUD
    //Endpoint 1: return a list of all user
    func index(req: Request)  throws -> EventLoopFuture<[Diy]> {
        return Diy.query(on: req.db)
            .with(\.$publisher)
            .all()
    }
    
    
    
    func getHandler(_ req: Request) throws -> EventLoopFuture<[Diy]> {
        guard let diy = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
            return Diy.query(on: req.db)
            .filter(\Diy.$id == diy)
            .with(\.$publisher)
            .all()
    
    }
    
    
    
    //Endpoint 2: create a new user
    func create(req: Request) throws -> EventLoopFuture<Diy> {
        let diy = try req.content.decode(Diy.self)
        return diy.save(on: req.db).map{diy}
    }
    
    //Endpoint 3: delete a user
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let uuid = req.parameters.get("id", as: UUID.self)
        return Diy
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
            .flatMap { diy in
                diy.delete(on: req.db)
            }
            .transform(to: .ok)
    }
    
    //Endpoint 4: update a user
    func update(req: Request) throws -> EventLoopFuture<Diy> {
        let input = try req.content.decode(Diy.self)
        let uuid = req.parameters.get("id", as: UUID.self)
        return Diy
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
            .flatMap { diy in
                diy.title = input.title
                diy.description = input.description
                diy.time = input.time
                diy.tools = input.tools
                diy.materials = input.materials
                diy.instructions = input.instructions
                diy.imageURL = input.imageURL
                diy.videoURL = input.videoURL
                return diy.save(on: req.db).map{diy}
            }
    }
    
    //Endpoint 5: uploadImage for a user
    private func uploadImage(req: Request) throws -> EventLoopFuture<Response> {
        
        let uuid = req.parameters.get("id", as: UUID.self)
        let file = try req.content.decode(File.self) //the json body should be file
        let path = req.application.directory.workingDirectory + file.filename
        
        //1. Fetching the list and aborting if notFound
        return Diy
            .find(uuid, on: req.db)
            .unwrap(orError: Abort(.notFound))
        //2. Save the file into a path
            .flatMap { diy in // flatMap used here since writeFile return Future
                req.fileio
                    .writeFile(file.data, at: path)
                    .map {diy} // map used here since it returns a type that is not a Future -> it will return that particular planet
            }
        //3. Update the planet with the updated data
            .flatMap { diy in
                let hostname = req.application.http.server.configuration.hostname
                let port = req.application.http.server.configuration.port
                diy.imageURL = "\(hostname):\(port)/\(file.filename)"
                //4. Return the updated planet as a response
                return diy
                    .update(on: req.db)
                    .map {diy}
                    .encodeResponse(status: .accepted, for: req)
            }
    }
    
    // uploadVide for a Diy
        func uploadVideo(req: Request) throws -> EventLoopFuture<Response> {
    
            let uuid = req.parameters.get("id", as: UUID.self)
            let file = try req.content.decode(File.self)
            //the json body should be file
            let path = req.application.directory.workingDirectory + file.filename
    
            return Diy
                .find(uuid, on: req.db)
                .unwrap(orError: Abort(.notFound))
    
            // Save the file into a path
                .flatMap { Diy in
                    req.fileio
                        .writeFile(file.data, at: path)
                        .map {Diy}
                }
                .flatMap { Diy in
                    let hostname = req.application.http.server.configuration.hostname
                    let port = req.application.http.server.configuration.port
                    Diy.videoURL = "\(hostname):\(port)/\(file.filename)"
    
                    return Diy
                        .update(on: req.db)
                        .map {Diy}
                        .encodeResponse(status: .accepted, for: req)
                }
        }
}

