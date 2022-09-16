//
//  ApiError.swift
//  MyOkashi0111
//
//  Created by cmStudent on 2022/09/16.
//

import Foundation

enum ApiError: Error {
    case abnormalResponse
    case abnormalStatusCode(statusCode: Int)
    case failedDecodeJSON
}
