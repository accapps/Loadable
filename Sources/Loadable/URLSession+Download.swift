//
//  File.swift
//  
//
//  Created by Umut Artuvan on 18.11.22.
//

import Foundation
extension URLSession {
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
}
