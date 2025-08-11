//
//  HnbMacOSCodes.swift
//  Mixpanel_macOS
//
//  Created by Dev Apps on 8/11/25.
//  Copyright © 2025 Mixpanel. All rights reserved.
//

import Foundation

/// The wrapper class for the primary class `Mixpanel` for integrating Mixpanel with your app.
/// Because this class name is the same as the module name, which may cause errors.
/// See `https://github.com/apple/swift/issues/56573` for workarounds
open class HnbMixpanelWrapper {

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
