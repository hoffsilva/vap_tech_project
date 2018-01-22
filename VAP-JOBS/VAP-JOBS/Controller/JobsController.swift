//
//  JobsController.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
import CoreData

protocol AllJobsDelegate: class {
    func loadAllJobs()
    func showError(message: String)
}

class JobsController {
    
    weak var jobDelegate: AllJobsDelegate?
    
    var page = 1
    
    var arrayOfJobs = [Listing]()
    
    func getAllJobs() {
        Service.shared.fetch(requestLink: .getAllJobs, parameters: ["pageNumber":page]) { (response) in
            if let error = Service.verifyResult(response) {
                self.jobDelegate?.showError(message: error.description)
                return
            }
            self.parseJobs(response: response)
            self.saveJobsLocally()
        }
    }
    
    func getJobsByCategory(idOfCategory: Int) {
        Service.shared.fetch(requestLink: .getJobsByCategory, parameters: ["idOfCategory":idOfCategory]) { (response) in
            if let error = Service.verifyResult(response) {
                self.jobDelegate?.showError(message: error.description)
                return
            }
            self.parseJobs(response: response)
        }
    }
    
    
    func getJobsByLocation(idOfLocation: String) {
        Service.shared.fetch(requestLink: .getJobsByLocation, parameters: ["idOfLocation":idOfLocation]) { (response) in
            if let error = Service.verifyResult(response) {
                self.jobDelegate?.showError(message: error.description)
                return
            }
            self.parseJobs(response: response)
        }
    }
    
    
    func getJobsByType(typeOfJob: String) {
        Service.shared.fetch(requestLink: .getJobsByType, parameters: ["idOfType":typeOfJob]) { (response) in
            if let error = Service.verifyResult(response) {
                self.jobDelegate?.showError(message: error.description)
                return
            }
            self.parseJobs(response: response)
        }
    }
    
    func parseJobs(response: Any?) {
        let parsedResponse = (try! JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
        
        guard let listings = parsedResponse.value(forKey: "listings") as? NSDictionary else {
            self.jobDelegate?.showError(message: "Load jobs error. 😕")
            return
        }
        
        guard let listingList = listings.value(forKey: "listing") as? [[String:Any]] else {
            self.jobDelegate?.showError(message: "Load jobs error. 😕")
            return
        }
        
        for job in listingList {
            let newListing = Listing(object: job)
            self.arrayOfJobs.append(newListing)
        }
        self.jobDelegate?.loadAllJobs()
    }
    
    func saveJobsLocally() {
        
        let coreDataStack = CoreDataStack(modelName: "VAP_JOBS")
        
        let mc = coreDataStack.managedContext
        
        let jobEntity = NSEntityDescription.entity(forEntityName: "Job", in: mc)
        let job = NSManagedObject(entity: jobEntity!, insertInto: mc)
        
        for item in arrayOfJobs {
            if let applyURL = item.applyUrl {
                job.setValue(applyURL, forKey: "applyUrl")
            }
            if let companyLocation = item.company?.location?.name {
                job.setValue(companyLocation, forKey: "companyLocation")
            }
            if let companyLogo = item.company?.logo {
                job.setValue(companyLogo, forKey: "companyLogo")
            }
            if let companyName = item.company?.name {
                job.setValue(companyName, forKey: "companyName")
            }
            if let companyUrl = item.company?.url {
                job.setValue(companyUrl, forKey: "companyUrl")
            }
            if let descriptionValue = item.descriptionValue {
                job.setValue(descriptionValue, forKey: "descriptionValue")
            }
            if let howtoApply = item.applyUrl {
                job.setValue(howtoApply, forKey: "howtoApply")
            }
            if let id = item.id {
                job.setValue(id, forKey: "id")
            }
            if let keywords = item.keywords {
                job.setValue(keywords, forKey: "keywords")
            }
            if let perks = item.perks {
                job.setValue(perks, forKey: "perks")
            }
            if let title = item.title {
                job.setValue(title, forKey: "title")
            }
            if let url = item.url {
                job.setValue(url, forKey: "url")
            }
            do {
                try mc.save()
            } catch let error as NSError {
                print("Try to save: \(error), \(error.userInfo)")
            }
        }
        
    }
    
    func getJobsDataToShowInCell(job: Int) -> Listing {
        return arrayOfJobs[job]
    }
}
