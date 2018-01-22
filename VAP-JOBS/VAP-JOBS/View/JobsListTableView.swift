//
//  JobsListTableView.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 20/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
import SDWebImage

class JobsListTableView: UITableViewController {
    
    var jobsController = JobsController()
    var selectJob: Int!
    var isFiltering = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        definesPresentationContext = true
        jobsController.jobDelegate = self
        if !isFiltering {
            jobsController.getAllJobs()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobsController.arrayOfJobs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobcell", for: indexPath) as! JobTableViewCell
        let job = jobsController.getJobsDataToShowInCell(job: indexPath.row)
        let companyLogoString = job.company?.logo
        let companyLogoURL = URL(string: companyLogoString!)
        cell.imageOfCompany.sd_setImage(with: companyLogoURL, placeholderImage: nil, options: .allowInvalidSSLCertificates, progress: nil) { (image, error, imageCachedType, url) in
            if let loadedImage = image {
                cell.imageOfCompany.image = loadedImage
            } else {
                cell.imageOfCompany.image = #imageLiteral(resourceName: "genericCompanyLogo")
            }
        }
        cell.imageOfCompany.sd_setShowActivityIndicatorView(true)
        cell.titleOfPositionLabel.text = job.title
        cell.siteOfCompany.titleLabel?.text = job.company?.url
        cell.locationOfPositionLabel.text = job.company?.location?.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == jobsController.arrayOfJobs.count-1 {
            jobsController.page += 1
            self.pleaseWait()
            jobsController.getAllJobs()
        }
    }
    
    @IBAction func openCompanySite(_ sender: UIButton) {
        if let companySite = sender.titleLabel?.text {
            UIApplication.shared.open(URL(string: companySite)!, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectJob = indexPath.row
        performSegue(withIdentifier: "segueDetailJob", sender: self)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetailJob" {
            let dj = segue.destination as!  DetailJobTableView
            dj.job = jobsController.arrayOfJobs[selectJob]
        }
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Jobs"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
}

extension JobsListTableView: AllJobsDelegate {
    func loadAllJobs() {
        tableView.reloadData()
        self.clearAllNotice()
    }
    
    func showError(message: String) {
        self.noticeOnlyText(message)
        self.clearAllNotice()
    }
}

extension JobsListTableView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("sas")
    }
    
    
    
    
}
