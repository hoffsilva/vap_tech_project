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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        jobsController.jobDelegate = self
        jobsController.getAllJobs()
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
