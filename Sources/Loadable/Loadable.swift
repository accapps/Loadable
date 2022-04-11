//
//  Loadable.swift
//
//
//  Created by Umut Artuvan on 08.04.22.
//

import Foundation

/**
 Loadable simplifies the REST-API Calls and utilizes Swift 5 syntax
 - Author: [Umut Onat Artuvan](https://github.com/umutonat)
 - Version: 1.0.0
 */
public struct Loadable<T: Codable> {
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case head = "HEAD"
        case delete = "DELETE"
        case patch = "PATCH"
        case options = "OPTIONS"
        case connect = "CONNECT"
        case trace = "TRACE"
    }

    private var urlRequest: URLRequest

    /**
     Initializer of the Loadable

     - parameter url: `URL` for the request
     - parameter httpHeaders: Headers that has to be added to the request `[HTTPHeaderField: Value]`, default is empty
     - parameter httpMethod: One of the `HTTPMethod`s, default is `.get`
     - parameter httpBody: `Data` for the body of the request

     Example
     ```
     Loadable<Users>(url: URL(string: "https://catfact.ninja/fact")!)
     ```

     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.0.0
    */
    init(
        url: URL,
        httpHeaders: [String: String] = [:],
        httpMethod: HTTPMethod = .get,
        httpBody: Data? = nil
    ) {
        urlRequest = URLRequest(url: url)
        httpHeaders.forEach { (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
    }


/**
 Executes the request that is configured by initializer
 - returns: Provided type `T`

 Example
 ```
 let users: Users? = await Loadable<Users>(url: URL(string: "https://catfact.ninja/fact")!).request()
 ```
 - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
 - Version: 1.0.0
 */
    func request() async -> T? {
        do {
            let (data, _) = try await URLSession.shared.data(from: urlRequest)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Loadable Error: \(error)")
            return nil
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: Provided type `T` and urlResponse `(T, URLResponse)`

     Example
     ```
     let (users: Users?, urlResponse: URLResponse?) = await Loadable<Users>(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.0.0
    */
    func request() async -> (T?, URLResponse?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: urlRequest)
            return (try JSONDecoder().decode(T.self, from: data), urlResponse)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: Provided type `T` and statusCode `(T, Int)`

     Example
     ```
     let (users: Users?, statusCode: Int?) = await Loadable<Users>(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.0.0
    */
    func request() async -> (T?, Int?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(from: urlRequest)
            return (try JSONDecoder().decode(T.self, from: data), (urlResponse as? HTTPURLResponse)?.statusCode)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }
}
