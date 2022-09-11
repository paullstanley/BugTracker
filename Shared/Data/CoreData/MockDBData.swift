//
//  MockDBData.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

class MockCoreData {
    func populateDB(context: NSManagedObjectContext) {
        
        //MARK: Mock Projects
        context.perform {
            //MARK: User Mock Data
            let user1 = UserMO.findOrInsert(using: "Paull", in: context)
            
            user1.addToProjects(ProjectMO.findOrInsert(using: "magpie", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "raven", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "masthead", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "betho", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "reppit", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "IMS", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "memorize", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "IssueTrackingSystem", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "memoAmplifier", in: context))
            user1.addToProjects(ProjectMO.findOrInsert(using: "deadlight", in: context))
            
            //MARK: Project Mock Data
            let project0 = ProjectMO.findOrInsert(using: "deadlight", in: context)
            project0.creationDate = Date()
            
            let project1 = ProjectMO.findOrInsert(using: "magpie", in: context)
            project1.creationDate = Date()
            
            let project2 = ProjectMO.findOrInsert(using: "raven", in: context)
            project2.creationDate = Date()
            
            let project3 = ProjectMO.findOrInsert(using: "masthead", in: context)
            project3.creationDate = Date()
            
            let project4 = ProjectMO.findOrInsert(using: "betho", in: context)
            project4.creationDate = Date()
            
            let project5 = ProjectMO.findOrInsert(using: "memoAmplifier", in: context)
            project5.creationDate = Date()
            
            let project6 = ProjectMO.findOrInsert(using: "memorize", in: context)
            project6.creationDate = Date()
            
            let project7 = ProjectMO.findOrInsert(using: "reppit", in: context)
            project7.creationDate = Date()
            
            let project8 = ProjectMO.findOrInsert(using: "IMS", in: context)
            project8.creationDate = Date()
            
            let project9 = ProjectMO.findOrInsert(using: "IssueTrackingSystem", in: context)
            project9.creationDate = Date()
            
            //MARK: Issue Mock Data
            let issue1 = IssueMO.findOrInsert(using: "Something not working1", in: context)
            issue1.type = "Bug"
            issue1.creationDate = Date()
            issue1.project = ProjectMO.findOrInsert(using: "magpie", in: context)
            
            let issue2 = IssueMO.findOrInsert(using: "Something not working2", in: context)
            issue2.type = "Bug"
            issue2.creationDate = Date()
            issue2.project = ProjectMO.findOrInsert(using: "raven", in: context)
            
            let issue3 = IssueMO.findOrInsert(using: "Something not working3", in: context)
            issue3.type = "Todo"
            issue3.creationDate = Date()
            issue3.project = ProjectMO.findOrInsert(using: "masthead", in: context)
            
            let issue4 = IssueMO.findOrInsert(using: "Something not working4", in: context)
            issue4.type = "Bug"
            issue4.creationDate = Date()
            issue4.project = ProjectMO.findOrInsert(using: "betho", in: context)
            
            let issue5 = IssueMO.findOrInsert(using: "Something not working5", in: context)
            issue5.type = "Bug"
            issue5.creationDate = Date()
            issue5.project = ProjectMO.findOrInsert(using: "reppit", in: context)
            
            let issue6 = IssueMO.findOrInsert(using: "Something not working6", in: context)
            issue6.type = "Bug"
            issue6.creationDate = Date()
            issue6.project = ProjectMO.findOrInsert(using: "memorize", in: context)
            
            let issue7 = IssueMO.findOrInsert(using: "Something not working7", in: context)
            issue7.type = "Bug"
            issue7.creationDate = Date()
            issue7.project = ProjectMO.findOrInsert(using: "IssueTrackingSystem", in: context)
            
            let issue8 = IssueMO.findOrInsert(using: "Something not working8", in: context)
            issue8.type = "Bug"
            issue8.creationDate = Date()
            issue8.project = ProjectMO.findOrInsert(using: "memoAmplifier", in: context)
            
            let issue9 = IssueMO.findOrInsert(using: "Something not working9", in: context)
            issue9.type = "Bug"
            issue9.creationDate = Date()
            issue9.project = ProjectMO.findOrInsert(using: "deadlight", in: context)
            
            let issue10 = IssueMO.findOrInsert(using: "Something not working10", in: context)
            issue10.type = "Feedback"
            issue10.creationDate = Date()
            issue10.project = ProjectMO.findOrInsert(using: "magpie", in: context)
            
            let issue20 = IssueMO.findOrInsert(using: "Something not working20", in: context)
            issue20.type = "Todo"
            issue20.creationDate = Date()
            issue20.project = ProjectMO.findOrInsert(using: "raven", in: context)
            
            let issue30 = IssueMO.findOrInsert(using: "Something not working30", in: context)
            issue30.type = "Bug"
            issue30.creationDate = Date()
            issue30.project = ProjectMO.findOrInsert(using: "masthead", in: context)
            
            let issue40 = IssueMO.findOrInsert(using: "Something not working40", in: context)
            issue40.type = "Feedback"
            issue40.creationDate = Date()
            issue40.project = ProjectMO.findOrInsert(using: "betho", in: context)
            
            let issue50 = IssueMO.findOrInsert(using: "Something not working50", in: context)
            issue50.type = "Bug"
            issue50.creationDate = Date()
            issue50.project = ProjectMO.findOrInsert(using: "reppit", in: context)
            
            let issue60 = IssueMO.findOrInsert(using: "Something not working60", in: context)
            issue60.type = "Todo"
            issue60.creationDate = Date()
            issue60.project = ProjectMO.findOrInsert(using: "memorize", in: context)
            
            let issue70 = IssueMO.findOrInsert(using: "Something not working70", in: context)
            issue70.type = "Bug"
            issue70.creationDate = Date()
            issue70.project = ProjectMO.findOrInsert(using: "IssueTrackingSystem", in: context)
            
            let issue80 = IssueMO.findOrInsert(using: "Something not working80", in: context)
            issue80.type = "Bug"
            issue80.creationDate = Date()
            issue80.project = ProjectMO.findOrInsert(using: "memoAmplifier", in: context)
            
            let issue90 = IssueMO.findOrInsert(using: "Something not working90", in: context)
            issue90.type = "Bug"
            issue90.creationDate = Date()
            issue90.project = ProjectMO.findOrInsert(using: "deadlight", in: context)
            
            let issue200 = IssueMO.findOrInsert(using: "Something not working200", in: context)
            issue200.type = "Todo"
            issue200.creationDate = Date()
            issue200.project = ProjectMO.findOrInsert(using: "raven", in: context)
            
            let issue300 = IssueMO.findOrInsert(using: "Something not working300", in: context)
            issue300.type = "Bug"
            issue300.creationDate = Date()
            issue300.project = ProjectMO.findOrInsert(using: "masthead", in: context)
            
            let issue400 = IssueMO.findOrInsert(using: "Something not working400", in: context)
            issue400.type = "Feedback"
            issue400.creationDate = Date()
            issue400.project = ProjectMO.findOrInsert(using: "betho", in: context)
            
            let issue500 = IssueMO.findOrInsert(using: "Something not working500", in: context)
            issue500.type = "Bug"
            issue500.creationDate = Date()
            issue500.project = ProjectMO.findOrInsert(using: "reppit", in: context)
            
            let issue600 = IssueMO.findOrInsert(using: "Something not working600", in: context)
            issue600.type = "Todo"
            issue600.creationDate = Date()
            issue600.project = ProjectMO.findOrInsert(using: "memorize", in: context)
            
            let issue45 = IssueMO.findOrInsert(using: "Something not working45", in: context)
            issue45.type = "Bug"
            issue45.creationDate = Date()
            issue45.project = ProjectMO.findOrInsert(using: "betho", in: context)
            
            let issue55 = IssueMO.findOrInsert(using: "Something not working55", in: context)
            issue55.type = "Bug"
            issue55.creationDate = Date()
            issue55.project = ProjectMO.findOrInsert(using: "reppit", in: context)
            
            let issue65 = IssueMO.findOrInsert(using: "Something not working65", in: context)
            issue65.type = "Bug"
            issue65.creationDate = Date()
            issue65.project = ProjectMO.findOrInsert(using: "memorize", in: context)
            
            let issue75 = IssueMO.findOrInsert(using: "Something not working75", in: context)
            issue75.type = "Bug"
            issue75.creationDate = Date()
            issue75.project = ProjectMO.findOrInsert(using: "IssueTrackingSystem", in: context)
            do {
                try context.save()
            } catch {
                print("Unable to load mock data into the Core Data DB \(error.localizedDescription)")
            }
        }
    }
    
}
