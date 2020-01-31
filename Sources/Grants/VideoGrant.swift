
public struct VideoGrant: Grant {
    
    public var grantKey: String { "video" }
    
    public var payload: [String : Any] {
        
        if let room = self.room { return [Constants.roomKey:  room] }
        else { return [:] }
    }
    
    let room: String?
    
    public init(room: String? = nil) {
        self.room = room
    }
}
