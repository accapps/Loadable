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
 - Version: 1.2.0
 */
public struct Loadable {
    public enum HTTPMethod: String {
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
     Loadable(url: URL(string: "https://catfact.ninja/fact")!)
     ```

     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.2.0
     */
    public init(
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
     Initializer of the Loadable

     - parameter urlRequest: `URLRequest` for the request

     Example
     ```
     Loadable(urlRequest: URLRequest(url: URL(string: "https://catfact.ninja/fact")!))
     ```

     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.3.0
     */
    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }


    /**
     Executes the request that is configured by initializer
     - returns: Provided type `T`

     Example
     ```
     let users: Users? = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.4.0
     */
    public func request<T: Codable>(decoder: JSONDecoder = JSONDecoder()) async -> T? {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Loadable Error: \(error)")
            return nil
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: Provided type `T` and urlResponse `(T?, URLResponse?)`

     Example
     ```
     let (users: Users?, urlResponse: URLResponse?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.4.0
     */
    public func request<T: Codable>(decoder: JSONDecoder = JSONDecoder()) async -> (T?, URLResponse?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return (try decoder.decode(T.self, from: data), urlResponse)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: data and urlResponse `(Data?, URLResponse?)`

     Example
     ```
     let (data: Data?, urlResponse: URLResponse?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.2.0
     */
    public func request() async -> (Data?, URLResponse?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return (data, urlResponse)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: Provided type `T` and statusCode `(T?, Int?)`

     Example
     ```
     let (users: Users?, statusCode: Int?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.4.0
     */
    public func request<T: Codable>(decoder: JSONDecoder = JSONDecoder()) async -> (T?, Int?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return (try decoder.decode(T.self, from: data), (urlResponse as? HTTPURLResponse)?.statusCode)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Executes the request that is configured by initializer
     - returns: data and statusCode `(Data?, Int?)`

     Example
     ```
     let (data: Data?, statusCode: Int?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).request()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.2.0
     */
    public func request() async -> (Data?, Int?) {
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)
            return (data, (urlResponse as? HTTPURLResponse)?.statusCode)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Downloads data for the configured UrlRequest

     - parameter delegate: to handle events, default nil
     - returns: Downloaded file url and urlResponse `(URL?, UrlResponse?)`

     ignores `URLSessionTaskDelegate` iOS, tvOS < 15, watchOS < 8
     Example
     ```
     let (url: URL?, urlResponse: URLResponse?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!).download()
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.2.0
     */
    public func download(delegate: URLSessionTaskDelegate? = nil) async -> (URL?, URLResponse?) {
        do {
            return try await URLSession.shared.download(for: urlRequest, delegate: delegate)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }

    /**
     Downloads data for the configured UrlRequest

     - parameter fileUrl: file  to upload
     - parameter delegate: to handle events, default nil
     - returns: Downloaded file url and urlResponse `(URL?, UrlResponse?)`

     Make sure URLRequest has set `HTTPMethod` as .post
     ignores `URLSessionTaskDelegate` iOS, tvOS < 15, watchOS < 8
     Example
     ```
     let (url: URL?, urlResponse: URLResponse?) = await Loadable(url: URL(string: "https://catfact.ninja/fact")!, httpMethod: .post).upload(fileUrl: url)
     ```
     - Author:  [Umut Onat Artuvan](https://github.com/umutonat)
     - Version: 1.2.0
     */
    public func upload(fileUrl: URL, delegate: URLSessionTaskDelegate? = nil) async -> (Data?, URLResponse?) {
        guard urlRequest.httpMethod == HTTPMethod.post.rawValue else {
            print("Loadable Error: make sure HTTPMethod is set to .post")
            return (nil, nil)
        }
        do {
            return try await URLSession.shared.upload(for: urlRequest, fromFile: fileUrl, delegate: delegate)
        } catch {
            print("Loadable Error: \(error)")
            return (nil, nil)
        }
    }
}
