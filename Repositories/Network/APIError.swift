// ====--------------------------------------------------------====
// Futures
// https://github.com/genius/future
// ====--------------------------------------------------------====
import Foundation

/**
 An uninhabitable enum that can be used to denote when there is no
 possible error in a Future
 */

public enum APIError: Error {
    case unavailable
}
