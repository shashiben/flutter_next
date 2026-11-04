## 0.0.4

### Fixes
- Export validators, device helpers, and the remaining extensions. Import `package:dev_utils/dev_utils.dart`. `package:dev_utils/screen_utils.dart` still works.
- `FileUtils.getFileSize` accepts fractional byte counts and uses 1000-based units.
- `isMobile` follows width.
- Gesture extensions use `GestureDetector`, so they no longer need a `Material` ancestor.
- Credit card checks use the Luhn algorithm.

### Updates
- SDK `^3.8.0` and Flutter `>=3.32.0`.
- `getDeviceType` uses `defaultTargetPlatform`. ChromeOS is reported as Linux.

## 0.0.3 - 2024-12-13

### ✨ New Features
- Added **Validators** for common input types (email, password, phone numbers, etc.) for easier form handling.
- Enhanced **BuildContext extensions** for easier access to theme data, media query, and responsive breakpoints.
- Introduced **Widget Padding extensions** for quick and flexible padding options: `pad()`, `paddingSymmetric()`, `customPadding()`.
- Added **Password validation utility** to check for strong passwords and provide user feedback.

### 🛠️ Improvements
- Optimized utilities for better performance and streamlined code.

## 0.0.2
- ♻️ refactored code

## 0.0.1 

* Required utils are made
