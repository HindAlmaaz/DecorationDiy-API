//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import FluentPostgresDriver

struct CreateUser: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("first_name", .string)
            .field("last_name", .string)
            .field("social_media", .string)
            .field("picture", .string)
            .create()
    }
    
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}

