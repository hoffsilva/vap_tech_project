//
//  FilterJobsTableView.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit

class FilterJobsView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categoryController = CategoryController()
    var locationController = LocationController()
    var typeController = TypeController()
    var selectedCategory : Int!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControlFilter: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        filterJobs(segmentedControlFilter)
        categoryController.categoryDelegate = self
        locationController.locationDelegate = self
        typeController.typeDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Controllers
    
    @IBAction func filterJobs(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loadCategories()
        } else if sender.selectedSegmentIndex == 1 {
            loadLocations()
        } else {
            loadTypes()
        }
    }
    
    func loadCategories() {
        categoryController.getCategories()
    }
    
    func loadLocations() {
        locationController.getLocations()
    }
    
    func loadTypes() {
        typeController.getTypes()
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        if segmentedControlFilter.selectedSegmentIndex == 0 {
            let category = categoryController.getCategoryDataToShowInCell(category: indexPath.row)
            cell.textLabel?.text = category.name ?? "name"
        } else if segmentedControlFilter.selectedSegmentIndex == 1 {
            let location = locationController.getLocationDataToShowInCell(location: indexPath.row)
            cell.textLabel?.text = location.name ?? "name"
        } else {
            let type = typeController.getTypeDataToShowInCell(type: indexPath.row)
            cell.textLabel?.text = type.name ?? "name"
        }
        
        return cell
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControlFilter.selectedSegmentIndex == 0 {
            return categoryController.arrayOfCategory.count
        } else if segmentedControlFilter.selectedSegmentIndex == 1 {
            return locationController.arrayOfLocation.count
        } else {
            return typeController.arrayOfType.count
        } 
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowJobsListByFilter" {
            let vc = segue.destination as! JobsListTableView
            vc.isFiltering = true
            if segmentedControlFilter.selectedSegmentIndex == 0 {
                vc.jobsController.getJobsByCategory(idOfCategory: Int(categoryController.getCategoryDataToShowInCell(category: selectedCategory).id!)!)
            } else if segmentedControlFilter.selectedSegmentIndex == 1 {
                vc.jobsController.getJobsByLocation(idOfLocation: locationController.getLocationDataToShowInCell(location: selectedCategory).id!)
            } else {
                vc.jobsController.getJobsByType(typeOfJob: typeController.getTypeDataToShowInCell(type: selectedCategory).id!)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = indexPath.row
        performSegue(withIdentifier: "segueShowJobsListByFilter", sender: self)
    }
    

}

extension FilterJobsView: CategoryDelegate {
    func loadCategorySuccessful() {
        tableview.reloadData()
    }
    
    func showError(message: String) {
        self.noticeOnlyText(message)
    }
}

extension FilterJobsView: LocationDelegate {
    func loadLocationSuccessful() {
        tableview.reloadData()
    }
}

extension FilterJobsView: TypeDelegate {
    func loadTypeSuccessful() {
        tableview.reloadData()
    }
    
    
}
