//
//  Fetcher.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import Foundation

class Fetcher<Response: Decodable> {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch(completion: @escaping (_ result: Result<Response, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(InvalidResponse()))
                return
            }

            guard 200..<301 ~= response.statusCode else {
                completion(.failure(InvalidStatusCode()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NoDataError()))
                return
            }
            
            if let response = try? JSONDecoder().decode(Response.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(ParsingError()))
            }
        }

        task.resume()
    }
    
    
}

struct BadURL: Error {
    
}


struct InvalidResponse: Error {
    
}

struct InvalidStatusCode: Error {
    
}

struct NoDataError: Error {
    
}

struct ParsingError: Error {
    
}
