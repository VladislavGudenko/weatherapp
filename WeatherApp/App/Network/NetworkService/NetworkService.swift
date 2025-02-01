//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Владислав Гуденко on 01.02.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    private func request(_ target: TargetType, completion: @escaping (Result<Data, Error>) -> Void) {
        var urlComponents = URLComponents(url: target.baseURL.appendingPathComponent(target.path), resolvingAgainstBaseURL: false)

        if target.method == "GET", let params = target.parameters {
            urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = target.method
        request.allHTTPHeaderFields = target.headers

        if target.method != "GET", let params = target.parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func request<T: Decodable>(_ target: TargetType, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        request(target) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
