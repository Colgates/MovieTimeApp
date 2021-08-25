//
//  Route.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 21.07.2021.
//

import Foundation

enum Route: String, CaseIterable {
    
    static let baseURL = "https://imdb-api.com/en/API/"
    
    case comingSoon
    case inTheaters
    case mostPopularTVs
    case mostPopularMovies
    case top250TVs
    case top250movies
    case search
    case movieByID
    case actorByID
    
    var description: String {
        switch self {
        case .comingSoon:
            return "ComingSoon/"
        case .inTheaters:
            return "InTheaters/"
        case .mostPopularTVs:
            return "MostPopularTVs/"
        case .mostPopularMovies:
            return "MostPopularMovies/"
        case .top250TVs:
            return "Top250TVs/"
        case .top250movies:
            return "Top250Movies/"
        case .search:
            return "Search/"
        case .movieByID:
            return "Title/"
        case .actorByID:
            return "Name/"
        }
    }
}
