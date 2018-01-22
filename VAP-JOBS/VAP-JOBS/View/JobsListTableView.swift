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
    
    @IBOutlet weak var alertHeaderView: UIView!
    
    var jobsController = JobsController()
    var selectJob: Int!
    var isFiltering = false
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pleaseWait()
        configureSearchBar()
        definesPresentationContext = true
        jobsController.jobDelegate = self
        if !isFiltering {
            jobsController.getAllJobs()
        }
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Update Jobs list")
        tableView.refreshControl?.addTarget(self, action: #selector(loadJobsList), for: .valueChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if jobsController.arrayOfJobs.count == 0 {
            alertHeaderView.isHidden = false
            return alertHeaderView
        } else {
            alertHeaderView.isHidden = true
            return alertHeaderView
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if jobsController.arrayOfJobs.count == 0 {
            return tableView.frame.height/2
        } else {
            return 1
        }
    }
    
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
            jobsController.getAllJobs()
        } 
    }
    
    @objc
    @IBAction func loadJobsList() {
        self.pleaseWait()
        jobsController.getAllJobs()
        tableView.refreshControl?.endRefreshing()
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
        searchController.searchBar.placeholder = "Search Jobs keywords separated by comma."
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
        tableView.refreshControl?.endRefreshing()
        self.clearAllNotice()
        tableView.reloadData()
        tableView.reloadInputViews()
    }
    
    func showError(message: String) {
        self.noticeOnlyText(message)
        self.clearAllNotice()
    }
}

extension JobsListTableView: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        jobsController.arrayOfJobs.removeAll()
        tableView.reloadData()
        jobsController.getJobsBySearch(parameter: searchController.searchBar.text!)
    }
}
