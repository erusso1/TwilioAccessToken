import Foundation
import JWT
import Service

public struct TwilioAccessToken: Service {
  
  public var signingKeySid: String
  public var accountSid: String
  public var secret: String
  public var ttl: TimeInterval

  public var identity: String?
  public var nbf: Date?
  
  var grants: [Grant] = []

  public init(accountSid: String, signingKeySid: String, secret: String, ttl: TimeInterval = 3600) {
    self.signingKeySid = signingKeySid
    self.accountSid = accountSid
    self.secret = secret
    self.ttl = ttl
  }
  
  public mutating func addGrant(_ grant: Grant) {
    
    self.grants.append(grant)
  }

  public func toJwt() throws -> String {
    
    let now = Int(Date().timeIntervalSince1970)
    
    var grants = Object()

    for grant in self.grants {
      grants[grant.grantKey] = grant.payload
    }
    
    if let identity = self.identity {
      grants["identity"] = identity
    }
                
    let payload = Payload(
        identifier: "\(self.signingKeySid)-\(now)",
        issuer: self.signingKeySid,
        sub: self.accountSid,
        expiration: Date(timeIntervalSinceNow: ttl),
        notBefore: nbf,
        grants: grants
    )

    // Sign using secret
    
    let header = JWTHeader(alg: "HS256", typ: "JWT", cty: "twilio-fpa;v=1")
    let jwt = JWT<Payload>(header: header, payload: payload)
    let tokenData = try JWTSigner.hs256(key: self.secret).sign(jwt)
    
    guard let token = String(data: tokenData, encoding: .utf8) else { throw JWTError(identifier: "malformed_token", reason: "Unable to decode JWT token string from data.") }

    return token
  }
}
