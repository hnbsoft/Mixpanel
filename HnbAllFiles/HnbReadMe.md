## How to build this framework

Simply double-click `hnbarchive.command` script to build this framework into BinFrameworks folder.


## How to use this framework for macOS app project

In AppDelegate.swift file, import Mixpanel and add some code as below:

```swift
import Mixpanel

func applicationDidFinishLaunching(_ aNotification: Notification) {

    // 1. Mixpanel Setup - Replace with your own Project Token
    HnbMixpanel.shared.initialize(<#"YOUR_TOKEN"#>)

    // 2. Mixpanel Identify Users
    HnbMixpanel.shared.identifyWithUserUniqueUUIDIdentifier()

    // Optionally define some attributes of current user
    // HnbMixpanel.shared.peopleSetOnce(with: propertiesDict)  // Initial Setup Once
    //
    // HnbMixpanel.shared.peopleSet(with: propertiesDict)
    // HnbMixpanel.shared.peopleSet(propertyName, toStringValue: stringValue)
    // HnbMixpanel.shared.peopleSet(propertyName, toIntValue: intValue)
    // HnbMixpanel.shared.peopleSet(propertyName, toDoubleValue: doubleValue)
    // HnbMixpanel.shared.peopleSet(propertyName, toURLValue: urlValue)

    // 3. Mixpanel Must increase App Run Count, and then recommended to track "App Launched" event here.
    HnbMixpanel.shared.increaseAppRunCountAndThenTrackAppLaunchedEvent()

    // Mixpanel Track Other Events anywhere in your project
    HnbMixpanel.shared.track(<#"Event Name"#>, properties: [
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


___
## Fixed issues

1. The value of `NSPrincipalClass` item is empty in Info.plist file, I deleted this item at 2025.12.26 15:35 
2. The `TARGETED_DEVICE_FAMILY` build setting item of *Mixpanel_macOS* target is deleted at 2025.12.26 16:33
3. The `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` build setting item of *Mixpanel_macOS* target is deleted at 2025.12.26 16:47.
