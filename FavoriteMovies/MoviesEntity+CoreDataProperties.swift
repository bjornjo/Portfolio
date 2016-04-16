//
//  MoviesEntity+CoreDataProperties.swift
//  FavoriteMovies
//
//  Created by Bjørn Johannessen on 16.04.2016.
//  Copyright © 2016 BjornJohannessen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MoviesEntity {

    @NSManaged var genre: String?
    @NSManaged var imdbID: String?
    @NSManaged var movieTitle: String?
    @NSManaged var myRating: String?
    @NSManaged var myReview: String?
    @NSManaged var playtime: String?
    @NSManaged var poster: String?
    @NSManaged var rating: String?
    @NSManaged var yearReleased: String?

}
