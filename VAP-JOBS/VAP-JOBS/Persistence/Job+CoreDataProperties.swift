//
//  Job+CoreDataProperties.swift
//  
//
//  Created by Hoff Silva on 22/01/2018.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var relocationAssistance: Int16
    @NSManaged public var telecommuting: Int16
    @NSManaged public var howtoApply: String?
    @NSManaged public var descriptionValue: String?
    @NSManaged public var applyUrl: String?
    @NSManaged public var keywords: String?
    @NSManaged public var id: String?
    @NSManaged public var perks: String?
    @NSManaged public var postDate: String?
    @NSManaged public var title: String?
    @NSManaged public var companyName: String?
    @NSManaged public var companyUrl: String?
    @NSManaged public var companyLogo: String?
    @NSManaged public var companyLocation: String?
    @NSManaged public var url: String?

}
