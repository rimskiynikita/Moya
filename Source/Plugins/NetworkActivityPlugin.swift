import Foundation

/// Network activity change notification type.
public enum NetworkActivityChangeType {
    case Began, Ended
}

/// Provides each request with optional NSURLCredentials.
public final class NetworkActivityPlugin: Plugin {
    
    public typealias NetworkActivityClosure = (change: NetworkActivityChangeType) -> ()
    let networkActivityClosure: NetworkActivityClosure
    
    public init(networkActivityClosure: NetworkActivityClosure) {
        self.networkActivityClosure = networkActivityClosure
    }

    // MARK: Plugin

    /// Called by the provider as soon as the request is about to start
    public func willSendRequest(request: MoyaRequest, target: MoyaTarget) {
        networkActivityClosure(change: .Began)
    }
    
    /// Called by the provider as soon as a response arrives
    public func didReceiveResponse(result: Result<Moya.Response, Moya.Error>, target: MoyaTarget) {
        networkActivityClosure(change: .Ended)
    }
}
