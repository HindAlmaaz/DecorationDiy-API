//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "first_name")
    var firstName: String

    @Field(key: "last_name")
    var lastName: String
    
    @Field(key: "social_media")
    var socialMedia: String?
    
    @Field(key: "picture")
    var picture: String?
    
    @Children(for: \.$publisher)
    var projects: [Diy]
    
    init() { }

    init(id: UUID? = nil, firstName: String, lastName: String, socialMedia: String, picture: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.socialMedia = socialMedia
        self.picture = picture
    }
}
