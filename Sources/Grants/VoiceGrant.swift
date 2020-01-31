
public struct VoiceGrant: Grant {
  
  enum CodingKeys: String, CodingKey {
    
    case incomingAllow
    case outgoingApplicationSid
    case outgoingApplicationParams
    case pushCredentialSid
    case endpointId
  }
  
  let incomingAllow: Bool?
  let outgoingApplicationSid: String?
  let outgoingApplicationParams: Object?
  let pushCredentialSid: String?
  let endpointId: String?

  public init(incomingAllow: Bool? = nil, outgoingApplicationSid: String? = nil, outgoingApplicationParams: [String: Any]? = nil, pushCredentialSid: String? = nil, endpointId: String? = nil) {
    self.incomingAllow = incomingAllow
    self.outgoingApplicationSid = outgoingApplicationSid
    self.outgoingApplicationParams = outgoingApplicationParams
    self.pushCredentialSid = pushCredentialSid
    self.endpointId = endpointId
  }
    
  public var grantKey: String {
    return "voice"
  }
  
  public var payload: [String:Any] {
    
    var payloadValues: [String:Any] = [:]
    
    if incomingAllow == true {
      payloadValues["incoming"] = ["allow": true]
    }
    
    if let outgoingApplicationSid = self.outgoingApplicationSid {
      var outgoing = [String:Any]()
      outgoing[Constants.applicationSidKey] = outgoingApplicationSid
      
      if let outgoingApplicationParams = self.outgoingApplicationParams {
        outgoing["params"] = outgoingApplicationParams
      }
      
      payloadValues["outgoing"] = outgoing
    }
    
    if let pushCredentialSid = self.pushCredentialSid {
      payloadValues[Constants.pushCredentialSidKey] = pushCredentialSid
    }
    
    if let endpointId = self.endpointId {
      payloadValues[Constants.endpointIdKey] = endpointId
    }
    
    return payloadValues
  }

  init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.incomingAllow = try container.decodeIfPresent(Bool.self, forKey: .incomingAllow)
    self.outgoingApplicationSid = try container.decodeIfPresent(String.self, forKey: .outgoingApplicationSid)
    self.outgoingApplicationParams = try container.decode(Object.self, forKey: .outgoingApplicationParams)
    self.pushCredentialSid = try container.decodeIfPresent(String.self, forKey: .pushCredentialSid)
    self.endpointId = try container.decodeIfPresent(String.self, forKey: .endpointId)
  }
  
  func encode(to encoder: Encoder) throws {
    
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(incomingAllow, forKey: .incomingAllow)
    try container.encode(outgoingApplicationSid, forKey: .outgoingApplicationSid)
    try container.encode(outgoingApplicationParams, forKey: .outgoingApplicationParams)
    try container.encode(pushCredentialSid, forKey: .pushCredentialSid)
    try container.encodeIfPresent(endpointId, forKey: .endpointId)
  }
}
