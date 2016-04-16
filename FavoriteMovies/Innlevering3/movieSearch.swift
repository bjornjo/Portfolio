//
//  searchTask.swift
//  Innlevering3
//
//  Created by Bjørn Johannessen on 05.12.2015.
//  Copyright © 2015 BjornJohannessen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class movieSearch{
    
    var movie = [Movie]()
    
    func searchTask(url: NSURL, completion:(result: [Movie]) -> Void){
        let task = NSURLSession.sharedSession().dataTaskWithURL(url){(data, response, error) -> Void in
            if let urlContent = data {
                dispatch_async(dispatch_get_main_queue(), {
                    do{
                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        if let search = jsonResult["Search"] as? [[String : AnyObject]]{
                            for hit in search {
                                guard let hitTitle = hit["Title"] as? String else{
                                    return
                                }
                                guard let hitYear = hit["Year"] as? String else{
                                    return
                                }
                                guard let hitID = hit["imdbID"] as? String else{
                                    return
                                }
                                guard let hitPoster = hit["Poster"] as? String else{
                                    return
                                }
                            
                                let currentMovie = Movie(title: hitTitle, year: hitYear, imdbID: hitID, poster: hitPoster)

                                self.movie.append(currentMovie)
                            }
                        }
                        completion(result: self.movie)
                    } catch {
                        print("Json serialization failed")
                    }
                })
            }
        }
        task.resume()
    }
    
    func searchById (idString : String, completion:(result: Movie) -> Void){
        let url = NSURL(string: "http://www.omdbapi.com/?i=\(idString)&plot=short&r=json")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!){(data, response, error) -> Void in
            
            if let urlContent = data {
                
                dispatch_async(dispatch_get_main_queue(), {

                    do{

                        let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                        
                        guard let hitID = jsonResult["imdbID"] as? String else{
                            return
                        }
                        guard let hitTitle = jsonResult["Title"] as? String else{
                            return
                        }
                        guard let hitRating = jsonResult["imdbRating"] as? String else{
                            return
                        }
                        guard let hitGenre = jsonResult["Genre"] as? String else{
                            return
                        }
                        guard let hitRuntime = jsonResult["Runtime"] as? String else{
                            return
                        }
                        guard let hitPoster = jsonResult["Poster"] as? String else{
                            return
                        }
                        guard let hitRelease = jsonResult["Released"] as? String else{
                            return
                        }
                        

                        let currentMovie = Movie(imdbID: hitID, title: hitTitle, year: hitRelease, imdbRating: hitRating, genre: hitGenre, runtime: hitRuntime, poster: hitPoster)
                        
                        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        let context: NSManagedObjectContext = appDel.managedObjectContext
                        
                        let favoriteMovie = NSEntityDescription.insertNewObjectForEntityForName("MoviesEntity", inManagedObjectContext: context)
                        
                        favoriteMovie.setValue(currentMovie.imdbID, forKey: "imdbID")
                        favoriteMovie.setValue(currentMovie.title, forKey: "movieTitle")
                        favoriteMovie.setValue(currentMovie.year, forKey: "yearReleased")
                        favoriteMovie.setValue(currentMovie.imdbRating, forKey: "rating")
                        favoriteMovie.setValue(currentMovie.genre, forKey: "genre")
                        favoriteMovie.setValue(currentMovie.runtime, forKey: "playtime")
                        favoriteMovie.setValue(currentMovie.poster, forKey: "poster")
                        
                        do{
                            try context.save()
                            print(favoriteMovie)
                        } catch {
                            print("there was a problem")
                        }


                        completion(result: currentMovie)

                    } catch {
                        print("Json serialization failed")
                    }
                    
                })
            }
        }
        task.resume()
    }
    
    func removeMovie(imdbID : String, completion:(result: Movie) -> Void){
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "MoviesEntity")
        request.predicate = NSPredicate(format: "imdbID = %@", imdbID)
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0{
                for result in results as! [NSManagedObject] {
                    print(result.valueForKey("imdbID"))
                    context.deleteObject(result)
                    do{
                        try context.save()
                    } catch {
                        print("Couldn't save when trying to delete")
                    }
                    
                }
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    func requestImage(url: String, success: (UIImage?) -> Void) {
        requestURL(url, success: { (data) -> Void in
            if let d = data {
                success(UIImage(data: d))
            }
        })
    }
    
    func requestURL(url: String, success: (NSData?) -> Void, error: ((NSError) -> Void)? = nil) {
        NSURLConnection.sendAsynchronousRequest(
            NSURLRequest(URL: NSURL (string: url)!),
            queue: NSOperationQueue.mainQueue(),
            completionHandler: { response, data, err in
                if let e = err {
                    error?(e)
                } else {
                    success(data)
                }
        })
    }
    
    func updateMyReview(imdbID: String, review: String){
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "MoviesEntity")
        request.predicate = NSPredicate(format: "imdbID = %@", imdbID)
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0{
                for result in results as! [MoviesEntity] {
                    if(result.imdbID == imdbID){
                        result.myReview = review
                    }
                    do{
                        try context.save()
                    } catch {
                        print("Couldn't save when trying to delete")
                    }
                }
            }
        } catch {
            print("Fetch failed")
        }
    }
}

