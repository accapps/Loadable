//
//  URLSession+Data.swift
//  
//
//  Created by Umut Artuvan on 08.04.22.
//

import Foundation

extension URLSession {
    @available(watchOS, deprecated: 8.0, obsoleted: 8.0, message: "Use data function provided by Apple")
    @available(tvOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    @available(iOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }

    @available(watchOS, deprecated: 8.0, obsoleted: 8.0, message: "Use data function provided by Apple")
    @available(tvOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    @available(iOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    func download(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (URL, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.downloadTask(with: request) { url, response, error in
                guard let url = url, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (url, response))
            }
            task.resume()
        }
    }

    @available(watchOS, deprecated: 8.0, obsoleted: 8.0, message: "Use data function provided by Apple")
    @available(tvOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    @available(iOS, deprecated: 15.0, obsoleted: 15.0, message: "Use data function provided by Apple")
    func upload(for request: URLRequest, fromFile fileURL: URL, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.uploadTask(with: request, fromFile: fileURL) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}
