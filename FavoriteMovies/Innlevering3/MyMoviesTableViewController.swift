//
//  MyMoviesTableViewController.swift
//  Innlevering3
//
//  Created by Bjørn Johannessen on 04.12.2015.
//  Copyright © 2015 BjornJohannessen. All rights reserved.
//

import UIKit
import CoreData


class MyMoviesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var favoriteGenre: UILabel!
    
    let managedObjectContext: NSManagedObjectContext? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext
    
    var fetchedResultsController: NSFetchedResultsController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: allFavoriteMoviesRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        
        do{
            try fetchedResultsController?.performFetch()
        } catch {
            print("error")
        }
    }
    
    func allFavoriteMoviesRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "MoviesEntity")
        let sortDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchBatchSize = 10
        
        return fetchRequest
    }
    
    //MARK: UITableView Data Source and Delegate Functions
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return fetchedResultsController!.sections!.count
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController!.sections![section].numberOfObjects
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell", forIndexPath: indexPath) as UITableViewCell
        
        if let cellContact = fetchedResultsController?.objectAtIndexPath(indexPath) as? MoviesEntity {
            cell.textLabel!.text = "\(cellContact.movieTitle!)"
            
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Details") {
            if let destination = segue.destinationViewController as? DetailsViewController{
                
                let indexPath = self.tableView.indexPathForSelectedRow
                
                let fetchedResult = fetchedResultsController?.objectAtIndexPath(indexPath!) as? MoviesEntity
                destination.viaSegue = fetchedResult
            }
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case NSFetchedResultsChangeType.Insert:
            tableView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            print("insert")
            break
        case NSFetchedResultsChangeType.Delete:
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            print("delete")
            break
        case NSFetchedResultsChangeType.Move:
            print("move")
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            tableView.insertRowsAtIndexPaths(NSArray(object: newIndexPath!) as! [NSIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            break
        case NSFetchedResultsChangeType.Update:
            print("update")
            tableView.cellForRowAtIndexPath(indexPath!)
            break
        }
    }

  
}
