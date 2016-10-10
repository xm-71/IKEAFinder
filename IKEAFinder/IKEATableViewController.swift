//
//  IKEATableViewController.swift
//  IKEAFinder
//
//  Created by Elliott, Rob on 9/26/16.
//  Copyright © 2016 Elliott, Rob. All rights reserved.
//

import UIKit

class IKEATableViewController: UITableViewController {

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ikeaDataStore.sharedInstance.allIKEAs.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // WILL EXECUTE once FOR EACH TABLE CELL ON THE DISPLAY
        
        
        
        // Create or grab a reusable table cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! IKEAStoreTableViewCell
        
        
        
        // Get an instance of IKEA for the correct location in the table
        let IKEALocation = ikeaDataStore.sharedInstance.allIKEAs[indexPath.row]
        
        //cell.textLabel?.text = IKEALocation.name
        cell.lblIKEAStoreName.text = IKEALocation.name
        
        if IKEALocation.smalland {
            let imgSmalland = UIImage(named: "IconSmalland")
        
            cell.imgSmalland.image = imgSmalland
        }
        
        if let distanceFromHere = IKEALocation.distanceFromCurrentLocation{
        
            cell.lblDistance.text = "\(distanceFromHere) Miles from You"
        
        }
            
        else{
            
        cell.lblDistance.text = ""
            
        }
        
        
        return cell
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // CHECK THE SEGUE NAME
        
        if segue.identifier == "ikeaDetail" {
            
            // FIGURE OUT WHICH ROW WAS JUST TAPPED
            
            if let row = tableView.indexPathForSelectedRow?.row {
                print("\(row)")
                
                let tappedIKEA = ikeaDataStore.sharedInstance.allIKEAs[row]
                
                let detailVC = segue.destinationViewController as! DetailViewController
                
                
                
                detailVC.thisIKEA = tappedIKEA
            }
            
            print("executing segue")
        }
        
        
    }
}










