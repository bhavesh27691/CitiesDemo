//
//  CommonEnums.swift
//  ListViewPD
//
//  Created by Bhavesh Rathod on 27/01/25.
//

import Foundation

enum CitiesDataError: LocalizedError {
    case citiesNotFound
    case jsonParsingFailed
    case unexpectedError

    var errorDescription: String? {
        switch self {
        case .citiesNotFound:
            return Constants.JsonsErrorMessages.citiesNotFound
        case .jsonParsingFailed:
            return Constants.JsonsErrorMessages.jsonParsingFailed
        case .unexpectedError:
            return Constants.JsonsErrorMessages.unexpectedError
        }
    }

    var errorCode: Int {
        switch self {
        case .citiesNotFound:
            return 404
        case .jsonParsingFailed:
            return 200
        case .unexpectedError:
            return 500
        }
    }
}
