//
//  TableViewcontroller.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 06/11/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import Foundation
import UIKit
class TableViewcontroller: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var table: UITableView!
    
    
    var memes: [MeMe]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    
//    ------------------------------------------------
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // refresh the table to get the most recent added meme
        self.table.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false

    }
    
    
//    ------------------------------------------------
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
 //    ------------------------------------------------
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        when row selected there will be another view controller to show the complete MeMe photo
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
//    ------------------------------------------------
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topTxt
        
        cell.imageView?.image =  meme.original
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        
        // If the cell has a detail label, we will put the bottom text in it.
        if let detailTextLabel = cell.detailTextLabel {
            detailTextLabel.text = meme.bottomTxt
        }
        
        return cell
    }

    
//    ------------------------------------------------
    
}
