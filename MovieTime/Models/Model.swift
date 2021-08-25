//
//  Model.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import Foundation

// MARK: - Response Wrapper
struct ResponseWrapper: Codable, Hashable {
    let items: [Movie]
    let errorMessage: String?
}

// MARK: - Movie
struct Movie: Codable, Hashable {
    let id: String
    let rank: String?
    let title: String
    let year: String
    let image: String
    let crew: String?
    let imDbRating: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MovieDetails: Codable, Hashable {
    let id: String
    let title: String
    let originalTitle: String
    let fullTitle: String
    let year: String
    let image: String
    let runtimeStr: String
    let plot: String
    let actorList: [ActorList]
    let genres: String
    let contentRating, imDbRating, imDbRatingVotes, metacriticRating: String
//    let trailer: JSONNull?
    let similars: [Movie]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - ActorList
struct ActorList: Codable, Hashable {
    let id: String
    let image: String
    let name, asCharacter: String
}

struct ActorDetails: Codable, Hashable {
    let id, name, role: String
    let image: String
    let summary: String
    let birthDate: String?
    let deathDate: String?
    let awards, height: String
    let errorMessage: String
    let knownFor: [Movie]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - SearchResultsWrapper
struct SearchResults: Codable, Hashable {
    let searchType, expression: String?
    let results: [Results]?
    let errorMessage: String?
}

// MARK: - Result
struct Results: Codable, Hashable {
    let id, resultType: String
    let image: String
    let title, description: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
