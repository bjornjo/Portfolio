//
//  Movie.swift
//  Innlevering3
//
//  Created by Bjørn Johannessen on 05.12.2015.
//  Copyright © 2015 BjornJohannessen. All rights reserved.
//

import Foundation
import UIKit

class Movie{
    var title: String?
    var year: String?
    var poster: String?
    var posterImage: UIImage?
    var imdbID: String?
    var imdbRating: String?
    var genre: String?
    var runtime: String?
    
    init(title: String, year: String, imdbID: String, poster: String){
        self.title = title
        self.year = year
        self.imdbID = imdbID
        self.poster = poster
    }
    
    init(imdbID: String, title: String, year: String, imdbRating: String, genre: String, runtime: String, poster: String){
        self.imdbID = imdbID
        self.title = title
        self.year = year
        self.imdbRating = imdbRating
        self.genre = genre
        self.runtime = runtime
        self.poster = poster
    }
    
}