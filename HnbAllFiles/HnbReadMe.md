## Improvements

The following parts need to be improved, but it's not urgent, so I have not modify these for now.

1. The value of `NSPrincipalClass` item is empty in Info.plist file, I think it should be deleted.
2. Build settings for **Mixpanel_macOS** target:
    1. *NOT-Important*: The value of `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` should be NO.
    2. The `TARGETED_DEVICE_FAMILY` build setting item should be deleted.


## How to build this framework

Simply double-click `hnbarchive.command` script to build this framework into BinFrameworks folder.


## How to use this framework for macOS app project

1. Import Mixpanel into AppDelegate.swift file.
2. Initialize Mixpanel within `applicationDidFinishLaunching` function.
3. Some sample code:
```swift
import Mixpanel

func applicationDidFinishLaunching(_ aNotification: Notification) {

    // 1. Mixpanel Setup - Replace with your own Project Token
    HnbMixpanel.shared.initialize(token: <#"YOUR_TOKEN"#>)

    // 2. Mixpanel Identify Users
    HnbMixpanel.shared.identifyWithUserUniqueUUIDIdentifier()

    // Optionally define some attributes of current user
    // HnbMixpanel.shared.peopleSet(property: String, toStringValue to: String)
    // HnbMixpanel.shared.peopleSet(property: String, toIntValue to: Int)
    // HnbMixpanel.shared.peopleSet(property: String, toDoubleValue to: Double)
    // HnbMixpanel.shared.peopleSet(property: String, toURLValue to: URL)

    // 3. Mixpanel Track Events
    HnbMixpanel.shared.track(event: <#"App Launched"#>, properties: [
        "Signup Type": "Referral"
    ])
}

// Tells the delegate that the app is about to terminate
func applicationWillTerminate(_ notification: Notification) {

    // 999. Mixpanel Reset on Logout - After logout, call reset to clear local storage
    // New distinct_id is generated for events moving forward
    // Clears all stored properties including the distinct Id.
    // Useful if your app's user logs out.
    // Meaning calls to reset will generate a new random UUID.
    HnbMixpanel.shared.reset()
}

```
