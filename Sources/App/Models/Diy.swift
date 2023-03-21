//
//  File.swift
//  
//
//  Created by Zahra Majed Alzawad on 23/08/1444 AH.
//

import Fluent
import Vapor

final class Diy: Model, Content {
    static let schema = "diys"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "tools")
    var tools: String
    
    @Field(key: "materials")
    var materials: String
    
    @Field(key: "time")
    var time: String
    
    @Field(key: "instructions")
    var instructions: String
    
    @Field(key: "imageURL")
    var imageURL: String?
    
    @Field(key: "videoURL")
    var videoURL: String?
    
    @Parent(key: "user_id")
    var publisher: User

    init() { }

    init(id: UUID? = nil, title: String, description: String, tools: String, materials: String, time: String, instructions: String, imageURL: String?, videoURL: String?, userID: UUID) {
        self.id = id
        self.title = title
        self.description = description
        self.tools = tools
        self.materials = materials
        self.time = time
        self.instructions = instructions
        self.imageURL = imageURL
        self.videoURL = videoURL
        
        self.$publisher.id = userID
    }
}
