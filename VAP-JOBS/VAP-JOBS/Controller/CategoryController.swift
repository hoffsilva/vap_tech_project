//
//  CategoryController.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 21/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import Foundation

protocol CategoryDelegate: class {
    func loadCategorySuccessful()
    func showError(message: String)
}

class CategoryController {
    
    weak var categoryDelegate: CategoryDelegate?
    
    var arrayOfCategory = [Category]()
    
    func getCategories() {
        Service.shared.fetch(requestLink: .getCategories, parameters: [:]) { (response) in
            if let error = Service.verifyResult(response) {
                self.categoryDelegate?.showError(message: error.description)
                return
            }
            
            let parsedResponse = (try! JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)) as! NSDictionary
            
            guard let categories = parsedResponse.value(forKey: "categories") as? NSDictionary else {
                self.categoryDelegate?.showError(message: "Load jobs error. 😕")
                return
            }
            
            guard let category = categories.value(forKey: "category") as? [[String:Any]] else {
                self.categoryDelegate?.showError(message: "Load jobs error. 😕")
                return
            }
            
            self.arrayOfCategory.removeAll()
            
            for cat in category {
                print(cat)
                let newCategory = Category(object: cat)
                self.arrayOfCategory.append(newCategory)
            }

            self.categoryDelegate?.loadCategorySuccessful()
        }
    }
    
    func getCategoryDataToShowInCell(category: Int) -> Category {
        return arrayOfCategory[category]
    }
}

