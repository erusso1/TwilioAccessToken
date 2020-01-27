
public struct SyncGrant: Grant {
    
  public let serviceSid: String?
  public let endpointId: String?
    
  public var grantKey: String {
    return "data_sync"
  }

  public var payload: [String:Any] {
    var payloadValues: [String:String] = [:]

    if let serviceSid = self.serviceSid {
        payloadValues[Constants.serviceSidKey] = serviceSid
    }

    if let endpointId = self.endpointId {
        payloadValues[Constants.endpointIdKey] = endpointId
    }

    return payloadValues
  }
}
