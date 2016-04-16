//
//  SearchForMoviesViewController.swift
//  Innlevering3
//
//  Created by Bjørn Johannessen on 04.12.2015.
//  Copyright © 2015 BjornJohannessen. All rights reserved.
//

import UIKit
import CoreData

class SearchForMoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var movieSearchTableView: UITableView!
    
    @IBOutlet weak var searchForMoviesInput: UITextField!
    
    var lastSelectedIndexPath = NSIndexPath(forRow: -1, inSection: 0)
    
    var movie = [Movie](){
        didSet{
            movieSearchTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchForMoviesInput.delegate = self
    }
    
    
    @IBAction func searchButton(sender: AnyObject) {
        movie.removeAll()
        
        let formattedString = searchForMoviesInput.text!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let url = NSURL(string: "http://www.omdbapi.com/?s=\(formattedString)")
        
        movieSearch().searchTask(url!) { (result) -> Void in
            
            self.movie = result
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedRow = tableView.cellForRowAtIndexPath(indexPath)!
        let movieId = movie[indexPath.row].imdbID
        
        selectedRow.contentView.backgroundColor = UIColor.grayColor()
        
        if selectedRow.selected == true
        {
            if(selectedRow.accessoryType == UITableViewCellAccessoryType.None){
                selectedRow.accessoryType = UITableViewCellAccessoryType.Checkmark
                //Legger til filmen i CoreData som hentes i Mine Filmer
                movieSearch().searchById(movieId!, completion: { (result) -> Void in
                    
                })
            } else {
                selectedRow.accessoryType = UITableViewCellAccessoryType.None
                //Sletter filmen fra CoreData
                movieSearch().removeMovie(movieId!, completion: { (result) -> Void in
                    
                })

            }
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButton(textField)
        return true
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieSearchCell", forIndexPath: indexPath) as! SearchCell
        
        let cellData = movie[indexPath.row]
        
        if cell.selected
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        cell.movieTitleInCell.text = cellData.title
        cell.movieYearInCell.text = cellData.year
        let posterUrl = "\(cellData.poster!)&apikey=43ebffdc"
        
        movieSearch().requestImage(posterUrl) { (image) -> Void in
            cell.moviePosterInCell.image = image
        }
        
        return cell
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
