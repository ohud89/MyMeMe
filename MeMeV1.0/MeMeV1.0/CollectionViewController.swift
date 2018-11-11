//
//  CollectionViewController.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 06/11/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    //    ------------------------------------------------

    var memes: [MeMe]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    //    ------------------------------------------------

    
    @IBOutlet weak var memeCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //    ------------------------------------------------

    
    override func viewWillAppear(_ animated: Bool) {
        let space: CGFloat = 3.0
        let dimentio = (view.frame.width - (3 * space)) / 3
        let dimentioH = (view.frame.height - (3 * space)) / 4.5

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimentio, height: dimentioH)

        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        memeCollection.reloadData()
    }
    
    
    //    ------------------------------------------------

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
        return memes.count
    }
    
    //    ------------------------------------------------

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        // Configure the cell
        let mem = self.memes[(indexPath as NSIndexPath).row]
        cell.bottomLbl?.text = "  " + mem.bottomTxt
        cell.topLbl?.text  = "  " + mem.topTxt
        cell.memeImageView?.image = mem.original
        cell.memeImageView?.contentMode = .scaleAspectFill
        cell.memeImageView?.clipsToBounds = true
        cell.layer.cornerRadius = 5
    
    
    return cell
    
    }
    //    ------------------------------------------------

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //        when row selected there will be another view controller to show the complete MeMe photo
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    //    ------------------------------------------------

    
}

