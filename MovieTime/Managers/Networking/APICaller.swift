//
//  APICaller.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import Combine
import UIKit

class APICaller {
    
    static let shared = APICaller()
    
    func fetchMovies(route: Route) -> AnyPublisher<[Movie], Error> {

        let urlString = Route.baseURL + route.description + APICredentials.API_KEY
        
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ResponseWrapper.self, decoder: JSONDecoder())
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    func getMovieByID(route: Route, id: String) -> AnyPublisher<MovieDetails, Error> {
        
        let urlString =  Route.baseURL + route.description + APICredentials.API_KEY + id
        
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getActorByID(route: Route, id: String) -> AnyPublisher<ActorDetails, Error> {
        
        let urlString = Route.baseURL + route.description + APICredentials.API_KEY + id
        print(urlString)
        
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ActorDetails.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func search(route: Route, searchText: String) -> AnyPublisher<[Results], Error> {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = Route.baseURL + route.description + APICredentials.API_KEY + text
        print(text)
        guard let url = URL(string: urlString) else { return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .map { $0.results ?? []}
            .eraseToAnyPublisher()
    }
}
