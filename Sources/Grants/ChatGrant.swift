
public struct ChatGrant: Grant {
  
  public let serviceSid: String?
  public let endpointId: String?
  public let deploymentRoleSid: String?
  public let pushCredentialSid: String?
  
  public init(serviceSid: String? = nil, endpointId: String? = nil, deploymentRoleSid: String? = nil, pushCredentialSid: String? = nil) {
    
    self.serviceSid = serviceSid
    self.endpointId = endpointId
    self.deploymentRoleSid = deploymentRoleSid
    self.pushCredentialSid = pushCredentialSid
  }
    
  public var grantKey: String {
    return "chat"
  }

  public var payload: [String:Any] {
    var payloadValues: [String:String] = [:]

    if let serviceSid = self.serviceSid {
      payloadValues[Constants.serviceSidKey] = serviceSid
    }
    
    if let endpointId = self.endpointId {
      payloadValues[Constants.endpointIdKey] = endpointId
    }

    if let roleSid = self.deploymentRoleSid {
      payloadValues[Constants.deploymentRoleSidKey] = roleSid
    }

    if let pushSid = self.pushCredentialSid {
      payloadValues[Constants.pushCredentialSidKey] = pushSid
    }

    return payloadValues
  }
}
