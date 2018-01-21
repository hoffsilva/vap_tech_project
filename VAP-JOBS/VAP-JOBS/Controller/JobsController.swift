//
//  JobsController.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit

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
    }
    
    func getJobsDataToShowInCell(job: Int) -> Listing {
        return arrayOfJobs[job]
    }
}
