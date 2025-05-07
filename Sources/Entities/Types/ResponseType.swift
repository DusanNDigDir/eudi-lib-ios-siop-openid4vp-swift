/*
 * Copyright (c) 2023 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import Foundation
import SwiftyJSON

public enum ResponseType: String, Codable {
  case vpToken = "vp_token"
  case idToken = "id_token"
  case vpAndIdToken = "vp_token id_token"
  case code = "code"

  /// Initializes a `ResponseType` instance with the given authorization request object.
  ///
  /// - Parameter authorizationRequestObject: The authorization request object.
  /// - Throws: A `ValidatedAuthorizationError.unsupportedResponseType` if the response type is unsupported.
  public init(authorizationRequestObject: JSON) throws {
    let type = authorizationRequestObject["response_type"].stringValue
    guard let responseType = ResponseType(rawValue: type) else {
      throw ValidationError.unsupportedResponseType(type.isEmpty ? "unknown" : type)
    }

    self = responseType
  }

  /// Initializes a `ResponseType` instance with the given authorization request data.
  ///
  /// - Parameter authorizationRequestData: The authorization request data.
  /// - Throws: A `ValidatedAuthorizationError.unsupportedResponseType` if the response type is unsupported.
  public init(authorizationRequestData: UnvalidatedRequestObject) throws {
    guard let responseType = ResponseType(rawValue: authorizationRequestData.responseType ?? "") else {
      throw ValidationError.unsupportedResponseType(authorizationRequestData.responseType)
    }

    self = responseType
  }
}
