//
//  Top5Subreddits.swift
//  Top5Subreddit
//
//  Created by Ray Venenoso on 11/17/15.
//  Copyright © 2015 RAYVEN Creatives. All rights reserved.
//

import UIKit

class Top5SubredditsTVC: UITableViewController {

    var subredditsArr = NSArray()
    var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let moreCell = UINib(nibName: "RedditCell", bundle: nil)
        tableView.registerNib(moreCell, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 70
        
        startConnection()

    }

    func startConnection(){
        
        SwiftLoader.setConfig(configSwiftLoader())
        SwiftLoader.show(title: "Loading...", animated: true)
        
        let urlPath: String = "https://www.reddit.com/r/todayilearned/top.json?limit=5"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
       do{
        //var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        //var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        let jsonResult:NSDictionary!  = try NSJSONSerialization.JSONObjectWithData(self.data , options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        
            print(jsonResult)
        
            SwiftLoader.hide()
            subredditsArr = jsonResult.objectForKey("data")?.objectForKey("children") as! NSArray
            tableView.reloadData()
        } catch let error as NSError {
            print(error)
        }
    
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subredditsArr.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RedditCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! RedditCell
        
        cell.lblTitle.text = subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("title") as? String
        cell.lblAuthor.text = subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("author") as? String
        //cell.lblTitle.text = currentTable.objectForKey("title") as? String
        
        // cell.lblNumber.layer.cornerRadius = 20
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("SingleSubredditsTVC") as! SingleSubredditsTVC
        vc.txtTitle = (subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("title") as? String)!
        vc.txtAuthor = (subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("author") as? String)!
        let ups = subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("ups")?.stringValue
        
        //String(format: "UPVOTES = %@", ups)
        vc.txtUpvotes = String(format: "%@", ups!)
    //(subredditsArr.objectAtIndex(indexPath.row).objectForKey("data")?.objectForKey("ups") as? String)!
        
        //self.tabBarController?.navigationController?.navigationBarHidden = true
        self.navigationController?.showViewController(vc, sender:nil)
    }
    
    
    func configSwiftLoader()->SwiftLoader.Config{
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 120
        config.spinnerColor = .purpleColor()
        config.foregroundColor = .blackColor()
        config.foregroundAlpha = 0.2
        
        return config
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
