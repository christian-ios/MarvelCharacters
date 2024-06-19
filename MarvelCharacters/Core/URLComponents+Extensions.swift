//
//  URLComponents+Extensions.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//
import CryptoKit
import Foundation

extension URLComponents {
    mutating func addAuthorization(publicKey: String, privateKey: String) {
        let ts = String(Date().timeIntervalSince1970)
        let hashInput = "\(ts)\(privateKey)\(publicKey)"
        let hash = Insecure.MD5.hash(data: hashInput.data(using: .utf8)!)
            .map { String(format: "%02hhx", $0) }
            .joined()
        
        if queryItems == nil {
            queryItems = []
        }
        queryItems?.append(URLQueryItem(name: "apikey", value: publicKey))
        queryItems?.append(URLQueryItem(name: "ts", value: ts))
        queryItems?.append(URLQueryItem(name: "hash", value: hash))
    }
}
