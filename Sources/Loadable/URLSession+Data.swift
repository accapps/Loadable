//
//  URLSession+Data.swift
//  
//
//  Created by Umut Artuvan on 08.04.22.
//

import Foundation

extension URLSession {
    @available(iOS, deprecated: 15.0, message: "Use data function provided by Apple")
    func data(from urlRequest: URLRequest) async throws -> (Data, URLResponse) {
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
}
