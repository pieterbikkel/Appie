//
//  NetworkManager.swift
//  Appie
//
//  Created by Pieter Bikkel on 27/06/2023.
//


import Foundation
import Combine

enum NetworkError: Error {
    case badURL
    case badID
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func getData<T: Codable>(path: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "appie.nielsgermeraad.nl"
        components.path = path
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("de65c391-e447-4c02-a607-4caa72df0663", forHTTPHeaderField: "buro-ah-api-key")
        
        print(url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    // Handle the error
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(.failure(NSError(domain: "Empty data", code: 0, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    // Handle decoding error
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func postData<T: Codable, T2: Encodable>(path: String, method: String, type: T.Type, body: T2, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "appie.nielsgermeraad.nl"
        components.path = path
        
        guard let url = components.url else { return }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("de65c391-e447-4c02-a607-4caa72df0663", forHTTPHeaderField: "buro-ah-api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            print(jsonData)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    // Handle the error
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(.failure(NSError(domain: "Empty data", code: 0, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    // Handle decoding error
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func deleteData<T: Codable>(path: String, method: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "appie.nielsgermeraad.nl"
        components.path = path
        
        guard let url = components.url else { return }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("de65c391-e447-4c02-a607-4caa72df0663", forHTTPHeaderField: "buro-ah-api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method
        
        print(url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    // Handle the error
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    // Handle empty data
                    completion(.failure(NSError(domain: "Empty data", code: 0, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    // Handle decoding error
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


