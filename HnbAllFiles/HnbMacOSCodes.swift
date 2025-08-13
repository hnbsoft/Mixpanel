//
//  HnbMacOSCodes.swift
//  Mixpanel_macOS
//
//  Created by Dev Apps on 8/11/25.
//  Copyright © 2025 Mixpanel. All rights reserved.
//

import Foundation

/// Internal use, used to see whether you are using the correct version of HnbMixpanel framework.
fileprivate let kHnbMixpanelFrameworkInternalVersion: String = "40.25.0811.1"

/// class HnbMixpanelInfo
public class HnbMixpanelInfo: NSObject
{
    /// Get the current framework bundle object
    internal static let currentFrameworkBundle: Bundle = Bundle(for: HnbMixpanelInfo.self)

    /// HnbMixpanel framework info as a String
    @objc public static func frameworkInfoString() -> String
    {
        var infoString = "{HnbMixpanel Info: "

        // HnbMixpanel framework version
        infoString += "HnbMixpanelFrameworkInternalVersion = \(kHnbMixpanelFrameworkInternalVersion)"

        // Add a build info string
        // infoString += JBSCommonUtil.fetchHnbMixpanelCompileDateTimeString()

        // Add an ending separator
        infoString += "}"
        return infoString
    }
}


/// The wrapper class for the primary class `Mixpanel` for integrating Mixpanel with your app.
/// Because this class name is the same as the module name, which may cause errors.
/// See `https://github.com/apple/swift/issues/56573` for workarounds
open class HnbWrapperMixpanel {

    @discardableResult
    open class func initialize(options: MixpanelOptions) -> MixpanelInstance {
        return Mixpanel.initialize(options: options)
    }

  #if !os(OSX) && !os(watchOS)
    #error("Not support Non-macOS yet")
  #else
    // Initializes an instance of the API with the given project token (MAC OS ONLY).
    @discardableResult
    open class func initialize(
      token apiToken: String,
      flushInterval: Double = 60,
      instanceName: String? = nil,
      optOutTrackingByDefault: Bool = false,
      useUniqueDistinctId: Bool = false,
      superProperties: Properties? = nil,
      serverURL: String? = nil,
      useGzipCompression: Bool = false
    ) -> MixpanelInstance {
      return Mixpanel.initialize(
          token: apiToken,
          flushInterval: flushInterval,
          instanceName: instanceName,
          optOutTrackingByDefault: optOutTrackingByDefault,
          useUniqueDistinctId: useUniqueDistinctId,
          superProperties: superProperties,
          serverURL: serverURL,
          useGzipCompression: useGzipCompression
        )
    }

    @discardableResult
    open class func initialize(
      token apiToken: String,
      flushInterval: Double = 60,
      instanceName: String? = nil,
      optOutTrackingByDefault: Bool = false,
      useUniqueDistinctId: Bool = false,
      superProperties: Properties? = nil,
      proxyServerConfig: ProxyServerConfig,
      useGzipCompression: Bool = false
    ) -> MixpanelInstance {
      return Mixpanel.initialize(
          token: apiToken,
          flushInterval: flushInterval,
          instanceName: instanceName,
          optOutTrackingByDefault: optOutTrackingByDefault,
          useUniqueDistinctId: useUniqueDistinctId,
          superProperties: superProperties,
          proxyServerConfig: proxyServerConfig,
          useGzipCompression: useGzipCompression
        )
    }
  #endif  // os(OSX)

    open class func getInstance(name: String) -> MixpanelInstance? {
        return Mixpanel.getInstance(name: name)
    }

    open class func mainInstance() -> MixpanelInstance {
        return Mixpanel.mainInstance()
    }

    public class func safeMainInstance() -> MixpanelInstance? {
        return Mixpanel.safeMainInstance()
    }

    open class func setMainInstance(name: String) {
        Mixpanel.setMainInstance(name: name)
    }

    open class func removeInstance(name: String) {
        Mixpanel.removeInstance(name: name)
    }
}


// ============================================================================================================================
// ============================================================================================================================
#if os(OSX)

/// This class is used to encapsulate commonly used methods for operating Mixpanel class.
/// This class is applicable to both Objective-C projects and Swift projects.
/// In your client app, you may only just use this class.
///
/// - Important: This class ONLY supports macOS
public class HnbMixpanel: NSObject {
    /// Singleton: The shared instance of this class
    @objc public static let shared: HnbMixpanel = {
        return HnbMixpanel()
    }()

    /// Life cycle
    private override init() {
        super.init()
    }

    deinit {
    }

    // MARK: - Const Definitions
    /// The key for the user unique UUID identifier (The corresponding value is String).
    @objc public static let hnbMixpanelUserUniqueUUIDIdentifierKey: String = "HNBMixpanelUserUniqueUUIDIdentifier"


    // MARK: - Public Interfaces
    /// The initialize method, but it does not support `superProperties` argument (always nil).
    @objc public func initialize(
      token apiToken: String,
      flushInterval: Double = 60,
      instanceName: String? = nil,
      optOutTrackingByDefault: Bool = false,
      useUniqueDistinctId: Bool = false,
      serverURL: String? = nil,
      useGzipCompression: Bool = false
    ) {
        let superProperties: Properties? = nil
        Mixpanel.initialize(
          token: apiToken,
          flushInterval: flushInterval,
          instanceName: instanceName,
          optOutTrackingByDefault: optOutTrackingByDefault,
          useUniqueDistinctId: useUniqueDistinctId,
          superProperties: superProperties,
          serverURL: serverURL,
          useGzipCompression: useGzipCompression
        )
    }

    /// Find the user unique UUID identifier, which is persistent across app launches.
    @objc public func userUniqueUUIDIdentifier() -> String
    {
        let systemDefaults: UserDefaults = UserDefaults.standard

        let userID: String? = systemDefaults.string(forKey: HnbMixpanel.hnbMixpanelUserUniqueUUIDIdentifierKey)
        if let theUserID: String = userID {
            return theUserID
        }
        else
        {
            let tmpUUID: UUID = UUID()
            let randomString: String = "HNBID-" + tmpUUID.uuidString

            // Save to defaults database
            systemDefaults.set(randomString, forKey: HnbMixpanel.hnbMixpanelUserUniqueUUIDIdentifierKey)
            systemDefaults.synchronize()
            return randomString
        }
    }

    /// Identify Users: This method allows you to see which users triggered each event in Mixpanel
    @objc public func identify(distinctId: String, usePeople: Bool = true, completion: (() -> Void)? = nil) {
        Mixpanel.mainInstance().identify(distinctId: distinctId, usePeople: usePeople, completion: completion)
    }

    /// Identify Users: This method use user unique UUID identifier as distinctId, which allows you to see which users triggered each event in Mixpanel
    @objc public func identifyWithUserUniqueUUIDIdentifier() {
        let userID = self.userUniqueUUIDIdentifier()
        self.identify(distinctId: userID)
    }

    /// After logout, call reset to clear local storage, you may call it like this: `.reset()`
    /// New "distinct_id" is generated for events moving forward.
    @objc public func reset(completion: (() -> Void)? = nil) {
        Mixpanel.mainInstance().reset(completion: completion)
    }

    /// This method allows you to define the attributes of each user for `String` value
    @objc public func peopleSet(property: String, toStringValue to: String) {
        Mixpanel.mainInstance().people.set(property: property, to: to)
    }

    /// This method allows you to define the attributes of each user for `Int` value
    @objc public func peopleSet(property: String, toIntValue to: Int) {
        Mixpanel.mainInstance().people.set(property: property, to: to)
    }

    /// This method allows you to define the attributes of each user for `Double` value
    @objc public func peopleSet(property: String, toDoubleValue to: Double) {
        Mixpanel.mainInstance().people.set(property: property, to: to)
    }

    /// This method allows you to define the attributes of each user for `URL` value
    @objc public func peopleSet(property: String, toURLValue to: URL) {
        Mixpanel.mainInstance().people.set(property: property, to: to)
    }

    // MARK: - Track Events
    /// Track an event with optional properties.
    ///
    /// - Important: The values in `properties` parameter must conform to `MixpanelType` protocol.
    ///              MixpanelType can be either String, Int, UInt, Double, Float, Bool, [MixpanelType], [String: MixpanelType], Date, URL, or NSNull.
    ///              Numbers are not NaN or infinity
    @objc public func track(event: String, properties: [String: Any]? = nil)
    {
        var compatiblePropertiesDict: [String: MixpanelType] = [:]
        if let thePropertiesDict: [String: Any] = properties
        {
            for (propName, propValue) in thePropertiesDict
            {
                if let theMixpanelType: MixpanelType = propValue as? MixpanelType {
                    compatiblePropertiesDict.updateValue(theMixpanelType, forKey: propName)
                }
            }
        }

        let resultingProperties: Properties? = compatiblePropertiesDict.isEmpty ? nil : compatiblePropertiesDict
        Mixpanel.mainInstance().track(event: event, properties: resultingProperties)
    }

    /// Flush batched events for ingestion immediately, you may call it like this: `.flush()`
    @objc public func flush(performFullFlush: Bool = false, completion: (() -> Void)? = nil) {
        Mixpanel.mainInstance().flush(performFullFlush: performFullFlush, completion: completion)
    }

}

#endif  // os(OSX)
// ----------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------------
