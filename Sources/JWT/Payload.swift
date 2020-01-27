//
//  File.swift
//  
//
//  Created by Ephraim Russo on 1/27/20.
//

import JWT

typealias Object = [String: Any]

struct Payload: JWTPayload {
  
  enum CodingKeys: String, CodingKey {
    
    case identifier = "jti"
    case issuer = "iss"
    case subject = "sub"
    case expiration = "exp"
    case notBefore = "nbf"
    case grants
  }
  
  var identifier: IDClaim
  var issuer: IssuerClaim
  var sub: SubjectClaim
  var expiration: ExpirationClaim
  var notBefore: NotBeforeClaim?
  var grants: Object
  
  init(
    identifier: String,
    issuer: String,
    sub: String,
    expiration: Date,
    notBefore: Date?,
    grants: Object
  ) {
    
    self.identifier = .init(value: identifier)
    self.issuer = .init(value: issuer)
    self.sub = .init(value: sub)
    self.expiration = .init(value: expiration)
    if let notBefore = notBefore { self.notBefore =  .init(value: notBefore) }
    else { self.notBefore = nil }
    self.grants = grants
  }
  
  func verify(using signer: JWTSigner) throws {
    
    try self.expiration.verifyNotExpired()
  }
  
  init(from decoder: Decoder) throws {
    
  
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.identifier = try container.decode(IDClaim.self, forKey: .identifier)
    self.issuer = try container.decode(IssuerClaim.self, forKey: .issuer)
    self.sub = try container.decode(SubjectClaim.self, forKey: .subject)
    self.expiration = try container.decode(ExpirationClaim.self, forKey: .expiration)
    self.notBefore = try container.decode(NotBeforeClaim.self, forKey: .notBefore)
    self.grants = try container.decode(Object.self, forKey: .grants)
  }
  
  func encode(to encoder: Encoder) throws {
    
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(identifier, forKey: .identifier)
    try container.encode(issuer, forKey: .issuer)
    try container.encode(sub, forKey: .subject)
    try container.encode(expiration, forKey: .expiration)
    try container.encodeIfPresent(notBefore, forKey: .notBefore)
    try container.encode(grants, forKey: .grants)
  }
}
