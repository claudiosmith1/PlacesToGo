//
//  CustomNetworkError.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.


import UIKit

protocol CustomNetworkErrorProtocol: Error {

    var title: String? { get }
    var code: Int? { get }
    var error: Error? { get }
    var message: String? { get }
}

struct CustomNetworkError: CustomNetworkErrorProtocol {

    public var error: Error?
    public var title: String?
    public var code: Int?
    public let message: String?

    var errDescription: String?     { return _description }
    var failureDescription: String? { return _description }
    private var _description: String

    public var localizedDescription: String {
        if let message = self.message {
            return message
        } else if let desc = error?.localizedDescription {
            return desc
        }
        return "undefined error"
    }

    public init(_ message: String, _ code: Int) {
        self.message = message
        self.code = code
        self.title = title ?? "Error"
        self._description = message
    }

    public init(_ error: ServiceError, _ title: String? = nil) {
        self.title = title ?? "Error"
        self._description = error.errorMessage
        self.error = error
        self.message = ""
    }

    public init(description: String, code: Int, title: String? = nil) {
        self.title = title ?? "Error"
        self._description = description
        self.code = code
        self.message = description
    }
}

enum ServiceError: Error {

    case apiError
    case invalidEndpoint
    case invalidResponse
    case invalidData
    case decodeError
    case noInternet

    public var errorMessage: String {
        switch self {
        case .apiError:
            return "Api não encontrada ou erro remoto desconhecido"
        case .invalidEndpoint:
            return "Endpoint não encontrado"
        case .invalidResponse:
            return "Response retornou vazio"
        case .invalidData:
            return "Response retornou dados vazios ou inválidos"
        case .decodeError:
            return "Erro ao decodificar o data retornado"
        case .noInternet:
            return "Sem conexão de internet"
        }
    }
}

struct ErrorKnown {
   static let noConnection = 13
}

public enum HTTPError: Int {
    case unidentified
    case notFound = 404
    case unauthorized = 401
}
