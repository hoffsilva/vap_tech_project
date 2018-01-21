//
//  TypeController.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 21/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import Foundation


protocol TypeDelegate: class {
    func loadTypeSuccessful()
    func showError(message: String)
}

class TypeController {
    
    weak var typeDelegate: LocationDelegate?
    
    var arrayOfType = [Type]()
    
    func getTypes() {
        Service.shared.fetch(requestLink: .getTypes, parameters: [:]) { (response) in
            if let error = Service.verifyResult(response) {
                self.typeDelegate?.showError(message: error.description)
                return
            }
            
            let parsedResponse = (try! JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            
            guard let types = parsedResponse.value(forKey: "types") as? NSDictionary else {
                self.typeDelegate?.showError(message: "Load types error. 😕")
                return
            }
            
            guard let type = types.value(forKey: "type") as? [[String:Any]] else {
                self.typeDelegate?.showError(message: "Load types error. 😕")
                return
            }
            
            self.arrayOfType.removeAll()
            
            for tp in type {
                print(tp)
                let newType = Type(object: tp)
                self.arrayOfType.append(newType)
            }
            
            self.typeDelegate?.loadLocationSuccessful()
        }
    }
    
    func getTypeDataToShowInCell(type: Int) -> Type {
        return arrayOfType[type]
    }
}
