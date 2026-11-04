# 🎉 Flutter Utils 🚀  
[![Pub Version](https://img.shields.io/pub/v/dev_utils)](https://pub.dev/packages/dev_utils) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT) [![Pub Points](https://img.shields.io/pub/points/dev_utils)](https://pub.dev/packages/dev_utils/score) [![Likes](https://img.shields.io/pub/likes/dev_utils)](https://pub.dev/packages/dev_utils)


<a href="https://www.buymeacoffee.com/shashiben" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

Welcome to **Flutter Utils**, your new best friend for Flutter development! 🎨

This utility package brings **convenience**, **efficiency**, and **simplicity** to your Flutter apps. With a wide variety of extensions, validators, and utilities, we’ve made it easier to build beautiful, responsive, and maintainable Flutter apps with **less boilerplate code**! 🧑‍💻✨

## Features 🌟

### 🛠️ **Extensions for `BuildContext`**  
Say goodbye to repetitive code! Our extensions on `BuildContext` give you instant access to useful properties like:
- 📱 **MediaQuery** – Screen size, orientation, and device pixel ratio.
- 🎨 **ThemeData** – Colors, typography, and more.
- 💻 **Breakpoints** – Responsive layout detection (`isMobile`, `isTablet`, `isDesktop`).
- 🚀 **Navigation** – Push and pop routes easily.

### 🧩 **Widget Padding Extensions**  
Add **padding** to any widget effortlessly:
- Uniform padding with `padding()`.
- Symmetric padding with `symmetricPadding()`.
- Custom padding for top, bottom, left, right with `customPadding()`.

### 📝 **Validators**  
No more manual validation! 🔥 Validate:
- 📧 **Emails** – Check for valid email addresses.
- 🔑 **Passwords** – Ensure passwords are strong enough.
- 📱 **Phone Numbers** – Validate phone number formats.
- 🏆 And many more! Quickly add these checks to your forms.

### 🌱 **Additional Utilities**  
- **Adaptive Padding**: Adjust padding based on the screen width 📐.
- **Dynamic Font Scaling**: Make text responsive to screen size! 🔤.
- **Safe Area Helpers**: Easy access to safe area padding & view insets 📱.

### 🎨 **TextStyle Extensions**  
Say goodbye to repetitive `TextStyle` configurations! Get access to a range of text style extensions that save time and boost productivity. Learn more in the [TextStyleExtensions documentation](docs/TextStyleExtensions.md).

## 🚀 How It Helps Developers

### 💪 **Less Boilerplate**  
Stop repeating yourself! Flutter Utils simplifies common tasks with clean and easy-to-use extensions, saving you time and effort. 🕒

### 📱 **Responsive Design Made Easy**  
Detect screen sizes and orientations with ease. Whether you’re building for **mobile**, **tablet**, or **desktop**, Flutter Utils has you covered. 🖥️📱

### 🔒 **Validate User Input Like a Pro**  
Forget writing manual validation logic. With just a call, you can validate email, phone numbers, and passwords. Let Flutter Utils handle the validation while you focus on building cool features. 🔐

### 🎨 **Theming and Styling at Your Fingertips**  
Quickly access theme properties, text styles, and colors without digging into `Theme.of(context)`. Just use the simple extensions to make your UI consistent and stylish! 💅

## 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dev_utils: latest_version
```

```dart
import 'package:dev_utils/dev_utils.dart';
```
