import Foundation
import CoreGraphics

class NavigationCameraLayer: CALayer {
    
    @NSManaged var pitch: CGFloat
    @NSManaged var altitude: CLLocationDistance
    @NSManaged var direction: CLLocationDirection
    @NSManaged var centerLatitude: CLLocationDegrees
    @NSManaged var centerLongitude: CLLocationDegrees
    
    enum CustomAnimationKey: String {
        case altitude
        case pitch
        case direction
        case centerLatitude
        case centerLongitude
    }
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        if let layer = layer as? NavigationCameraLayer {
            altitude = layer.altitude
            pitch = layer.pitch
            direction = layer.direction
            centerLatitude = layer.centerLatitude
            centerLongitude = layer.centerLongitude
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate class func isCustomAnimationKey(key: String) -> Bool {
        return !(CustomAnimationKey(rawValue: key) == nil)
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        return isCustomAnimationKey(key: key) || super.needsDisplay(forKey: key)
    }
    
    override func action(forKey event: String) -> CAAction? {
        guard NavigationCameraLayer.isCustomAnimationKey(key: event) else {
            return super.action(forKey: event)
        }
        
        guard let animation = super.action(forKey: "backgroundColor") as? CABasicAnimation else {
            setNeedsDisplay()
            return nil
        }
        
        guard let presentationLayer = presentation(),
              let customKey = CustomAnimationKey(rawValue: event) else {
            return super.action(forKey: event)
        }
        
        animation.keyPath = event
        
        switch customKey {
        case .altitude:
            animation.fromValue = presentationLayer.altitude
        case .pitch:
            animation.fromValue = presentationLayer.pitch
        case .direction:
            animation.fromValue = presentationLayer.direction
        case .centerLatitude:
            animation.fromValue = presentationLayer.centerLatitude
        case .centerLongitude:
            animation.fromValue = presentationLayer.centerLongitude
        }
        
        animation.toValue = nil
        return animation
    }
}
