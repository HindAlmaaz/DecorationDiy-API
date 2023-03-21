import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    
    let v1Routes = app.grouped("v1")
    // v1/user
    let userRoutes = v1Routes.grouped("user")
    try userRoutes.register(collection: UserController())
    
    // v1/project
    let projectRoutes = v1Routes.grouped("project")
    try projectRoutes.register(collection: DiyController())

}
