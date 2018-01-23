//
//  LocationController.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 21/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import Foundation

protocol LocationDelegate: class {
    func loadLocationSuccessful()
    func showError(message: String)
}

class LocationController {
    
    weak var locationDelegate: LocationDelegate?
    
    var arrayOfLocation = [Location]()
    
    func getLocations() {
        Service.shared.fetch(requestLink: .getLocations, parameters: [:]) { (response) in
            if let error = Service.verifyResult(response) {
                self.locationDelegate?.showError(message: error.description)
                return
            }
            
            let parsedResponse = (try! JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            
            guard let locations = parsedResponse.value(forKey: "locations") as? NSDictionary else {
                self.locationDelegate?.showError(message: "Load jobs error. 😕")
                return
            }
            
            guard let location = locations.value(forKey: "location") as? [[String:Any]] else {
                self.locationDelegate?.showError(message: "Load jobs error. 😕")
                return
            }
            self.arrayOfLocation.removeAll()
            for loca in location {
                print(loca)
                let newLocation = Location(object: loca)
                self.arrayOfLocation.append(newLocation)
            }
            self.locationDelegate?.loadLocationSuccessful()
        }
    }
    
    func getLocationDataToShowInCell(location: Int) -> Location {
        return arrayOfLocation[location]
    }
}
