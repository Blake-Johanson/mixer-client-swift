//
//  ReportPacket.swift
//  Pods
//
//  Created by Jack Cook on 3/5/16.
//
//

/// A packet sent with local control data.
public class InteractiveReportPacket: InteractivePacket, InteractiveSendable {
    
    /// Data on the state of all of the controls in the stream.
    public let controls: [InteractiveReportPacketControl]
    
    /**
     Used to initialize a report packet.
     
     :param: controls The data on all of the stream's controls.
     */
    public init(controls: [InteractiveReportPacketControl]) {
        self.controls = controls
        
        super.init()
    }
    
    public var identifier: String {
        return "data"
    }
    
    public func data() -> [String: AnyObject] {
        var data = [String: AnyObject]()
        
        var tactiles = [String]()
        var joysticks = [String]()
        
        for control in controls {
            if control is InteractiveReportPacketTactile {
                tactiles.append(control.description)
            } else if control is InteractiveReportPacketJoystick {
                joysticks.append(control.description)
            }
        }
        
        data["joystick"] = joysticks as AnyObject?
        data["tactile"] = tactiles as AnyObject?
        
        return data
    }
}

/// A representation of a base control's data.
public class InteractiveReportPacketControl: CustomStringConvertible {
    
    /// The id of the control.
    public let id: Int
    
    /**
     Used to initialize a base control's data.
     
     :param: id The id of the control.
     */
    public init(id: Int) {
        self.id = id
    }
    
    public var description: String {
        return ""
    }
}

/// A representation of a tactile's control data.
public class InteractiveReportPacketTactile: InteractiveReportPacketControl {
    
    /// True if the tactile is being pressed.
    public let down: Bool
    
    /**
     Used to initialize a tactile's control data.
     
     :param: id The id of the tactile.
     :param: down True if the tactile is being pressed.
     */
    public init(id: Int, down: Bool) {
        self.down = down
        
        super.init(id: id)
    }
    
    public override var description: String {
        return "{\"\(down ? "down" : "up")\": 1, \"id\": \(id)}"
    }
}

/// A representation of a joystick's control data.
public class InteractiveReportPacketJoystick: InteractiveReportPacketControl {
    
    /// The x coordinate of the nipple's position in the joystick, -1.0 < x < 1.0.
    public let x: Float
    
    /// The y coordinate of the nipple's position in the joystick, -1.0 < y < 1.0.
    public let y: Float
    
    /**
     Used to initialize a joystick's control data.
     
     :param: id The id of the joystick.
     :param: x The x coordinate of the nipple's position in the joystick, -1.0 < x < 1.0.
     :param: y The y coordinate of the nipple's position in the joystick, -1.0 < y < 1.0.
     */
    public init(id: Int, x: Float, y: Float) {
        self.x = x
        self.y = y
        
        super.init(id: id)
    }
    
    public override var description: String {
        return "{\"x\": \(x), \"y\": \(y), \"id\": \(id)}"
    }
}
