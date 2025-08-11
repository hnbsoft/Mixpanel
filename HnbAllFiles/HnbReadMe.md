## Improvements

The following parts need to be improved, but it's not urgent, so I have not modify these for now.

1. The value of `NSPrincipalClass` item is empty in Info.plist file, I think it should be deleted.
2. Build settings for **Mixpanel_macOS** target:
    1. *NOT-Important*: The value of `CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES` should be NO.
    2. The `TARGETED_DEVICE_FAMILY` build setting item should be deleted.
