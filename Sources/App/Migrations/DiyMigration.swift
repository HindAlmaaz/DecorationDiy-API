//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import FluentPostgresDriver

struct CreateDiys: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("diys")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id", onDelete: .cascade))
            .field("title", .string, .required)
            .field("description", .string)
            .field("time", .string)
            .field("tools", .string)
            .field("materials", .string , .required)
            .field("instructions", .string , .required)
            .field("imageURL", .string)
            .field("videoURL", .string)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("diys").delete()
    }
}
