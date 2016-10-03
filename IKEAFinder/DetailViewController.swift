//
//  DetailViewController.swift
//  IKEAFinder
//
//  Created by RobElliott on 10/3/16.
//  Copyright © 2016 Elliott, Rob. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var thisIKEA: IKEA!
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var imgStore: UIImageView!
    @IBOutlet var imgSmalland: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        print(thisIKEA.name)
        
        // WRITE INFORMATION TO THE LABELS AND IMAGE
        lblName.text = thisIKEA.name
        lblCity.text = thisIKEA.city
        
        let ikeaImage = thisIKEA.storeImage
        
        imgStore.image = UIImage(named: ikeaImage)
        
        // IF THIS STORE HAS A SMALLAND, SHOW THE IMAGE
        if (thisIKEA.smalland) {
            imgSmalland.image = UIImage(named: "IconSmalland")
        }
        
    }
    
    
}
