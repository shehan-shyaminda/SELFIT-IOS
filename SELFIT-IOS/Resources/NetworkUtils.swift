//
//  NetworkUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-17.
//

import Foundation
import UIKit

class NetworkManager {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case responseError
        case serverError(_ statusCode: Int)
        case decodingError
        case badRequestError(_ message: String)
    }
    
    private static var BaseURL: String {
        //        return "https://ios-assignment.onrender.com"
        return "http://localhost:3000"
    }
    
    static let login_URL: String = "/user/login"
    static let register_url: String = "/user/create"
    
    func performNetworkCall<T: Decodable>(_ endpoint: String, httpMethod: HTTPMethod, headers: [String: String]? = nil, httpBody: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: NetworkManager.BaseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField:"Accept")
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid response", code: 0, userInfo: nil)))
                return
            }
            
            print(httpResponse.statusCode)
            
            guard let res = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(NSError(domain: "Decoding error", code: 0, userInfo: nil)))
                return
            }
            
            let result = try? JSONSerialization.jsonObject(with: data, options: [])
            if let result = result as? [String: Any] {
                print(result)
            }
            
            completion(.success(res))
        }
        
        task.resume()
    }
}
