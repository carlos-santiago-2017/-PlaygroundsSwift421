//
//  ViewController.swift
//  FlickerSearch
//
//  Created by Carlos Santiago Cruz on 11/16/18.
//  Copyright © 2018 Carlos Santiago Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let reuseIdentifier = "FlickrCell"
    let itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var searches = [FlickrSearchResults]()
    let flickr = Flickr()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {
    func photoForIndexPath(_ indexPath: IndexPath) -> FlickrPhoto {
        return searches[(indexPath as NSIndexPath).section].searchResults[(indexPath as NSIndexPath).row]
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            // 1
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            textField.addSubview(activityIndicator)
            activityIndicator.frame = textField.bounds
            activityIndicator.startAnimating()
            
            flickr.searchFlickrForTerm(textField.text!) {
                results, error in
                activityIndicator.removeFromSuperview()
                if let error = error {
                    // 2
                    print("error searching: \(error)")
                    return
                }
                if let results = results {
                    // 3
                    print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                    self.searches.insert(results, at: 0)
                    // 4
                    self.collectionView.reloadData()
                }
                
            }
            textField.text = nil
            textField.resignFirstResponder()
        return true
        }
    }

