//
//  BeamVOD.swift
//  Pods
//
//  Created by Jack Cook on 6/12/16.
//
//

import SwiftyJSON

public struct BeamVOD {
    
    public let id: Int
    public let storageNode: String?
    public let baseUrl: String?
    public let mainUrl: String?
    public let format: String
    public let createdAt: NSDate?
    public let updatedAt: NSDate?
    public let recordingId: Int
    
    public var url: NSURL? {
        func filePath() -> String? {
            return [
                "dash": "manifest.mpd",
                "hls": "manifest.m3u8",
                "thumbnail": "source.json",
                "raw": "source.mp4",
                "chat": "source.json"
            ][format]
        }
        
        if let baseUrl = baseUrl, filePath = filePath() {
            return NSURL(string: "\(baseUrl)\(filePath)")
        } else if let storageNode = storageNode, mainUrl = mainUrl {
            return NSURL(string: "https://\(storageNode)/\(id)/\(mainUrl)")
        }
        
        return nil
    }
    
    init(json: JSON) {
        id = json["id"].int ?? 0
        storageNode = json["storageNode"].string
        baseUrl = json["baseUrl"].string
        mainUrl = json["mainUrl"].string
        format = json["format"].string ?? "unknown"
        createdAt = NSDate.fromBeam(json["createdAt"].string)
        updatedAt = NSDate.fromBeam(json["updatedAt"].string)
        recordingId = json["recordingId"].int ?? 0
    }
}
