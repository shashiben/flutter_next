# Next Animation Example & Documentation

This is the example and documentation app for the Next Animation package.

## Running the Example

1. Navigate to the example directory:
   ```bash
   cd animation_next/example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   # For web
   flutter run -d chrome
   
   # For mobile
   flutter run
   ```

## Features

- 📱 Responsive design (mobile and desktop)
- 🎨 Modern Material 3 UI
- 📚 Comprehensive documentation for all animation types
- 💻 Live code examples
- 🔍 Easy navigation with side menu
- 🌐 SEO-friendly routing

## Building for Web

To build the documentation for deployment:

```bash
flutter build web --release
```

The output will be in `build/web/` which can be deployed to any static hosting service.

