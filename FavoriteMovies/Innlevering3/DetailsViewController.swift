//
//  DetailsViewController.swift
//  Innlevering3
//
//  Created by Bjørn Johannessen on 16.12.2015.
//  Copyright © 2015 BjornJohannessen. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var detailImage: UIImageView!
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailReleasedLabel: UILabel!
    
    @IBOutlet weak var detailGenreLabel: UILabel!
    
    @IBOutlet weak var detailIMDBRatingLabel: UILabel!
    
    @IBOutlet weak var detailRuntimeLabel: UILabel!
    
    @IBOutlet var detailMyReview: UITextView!
    
    @IBOutlet var ratingControl: RatingControl!
    
    var viaSegue: NSManagedObject?
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        self.detailMyReview.delegate = self
        
        detailImage.image = UIImage(named:"image.jpg")
        
        if let cellData = viaSegue as? MoviesEntity{
            detailTitleLabel.text = cellData.movieTitle
            detailGenreLabel.text = cellData.genre
            detailIMDBRatingLabel.text = cellData.rating
            detailRuntimeLabel.text = cellData.playtime
            detailReleasedLabel.text = cellData.yearReleased
            detailMyReview.text = cellData.myReview
            
            let posterUrl = "\(cellData.poster!)&apikey=43ebffdc"
            
            movieSearch().requestImage(posterUrl) { (image) -> Void in
                self.detailImage.image = image
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let cellData = viaSegue as? MoviesEntity{
            let imdbId = cellData.imdbID
            let myReview = detailMyReview.text
            movieSearch().updateMyReview(imdbId!, review: myReview)
        }
        
        self.view.endEditing(true)
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            self.view.frame.origin.y += keyboardSize.height
        }
    }
}
