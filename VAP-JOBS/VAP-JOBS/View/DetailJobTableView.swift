//
//  DetailJobTableView.swift
//  VAP-JOBS
//
//  Created by Hoff Henry Pereira da Silva on 21/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
import SDWebImage

class DetailJobTableView: UITableViewController {
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyLocationLabel: UILabel!
    
    @IBOutlet weak var titleOfJobLabel: UILabel!
    
    @IBOutlet weak var descriptionofJobWebView: UIWebView!
    @IBOutlet weak var heightOfDescriptionConstrait: NSLayoutConstraint!
    
    @IBOutlet weak var perksOkJobWebView: UIWebView!
    @IBOutlet weak var heigthOfPerksContraint: NSLayoutConstraint!
    
    @IBOutlet weak var keywordsOfJobTextView: UITextView!
    @IBOutlet weak var heigthOfKeywords: NSLayoutConstraint!
    
    var job = Listing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDataJob()
    }
    
    func setDataJob() {
        
        if let companyImageUrlString = job.company?.logo {
            companyImageView.sd_setImage(with:URL(string: companyImageUrlString) , placeholderImage: nil, options: SDWebImageOptions.allowInvalidSSLCertificates, completed: { (image, error, cacheType, url) in
                if let loadedImage = image {
                    self.companyImageView.image = loadedImage
                } else {
                    self.companyImageView.image = #imageLiteral(resourceName: "genericCompanyLogo")
                }
            })
        }
        
        companyNameLabel.text = job.company?.name ?? "adasfdaf"
        companyLocationLabel.text = job.company?.location?.name ?? "asdadasd"
        titleOfJobLabel.text = job.title ?? "..."

        descriptionofJobWebView.scrollView.isScrollEnabled = false
        heightOfDescriptionConstrait.constant = CGFloat(job.descriptionValue!.characters.count/2)
        descriptionofJobWebView.loadHTMLString(job.descriptionValue! , baseURL: nil)
        
        perksOkJobWebView.scrollView.isScrollEnabled = false
        if let perks = job.perks {
            heigthOfPerksContraint.constant = CGFloat((job.perks?.characters.count)!/2)
            perksOkJobWebView.loadHTMLString(job.perks ?? "fdsfsdsdfs", baseURL: nil)
        }
        if let kw = job.keywords {
            heigthOfKeywords.constant = CGFloat(kw.characters.count/2)
            keywordsOfJobTextView.text = job.keywords ?? "asdadsdasd"
        }
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDataJob()
        tableView.reloadData()
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
        return 6
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func applyToJob(_ sender: UIButton) {
        if let applyJobString = job.applyUrl {
            UIApplication.shared.open(URL(string: applyJobString)!, options: [:], completionHandler: nil)
        }
    }
    

}
