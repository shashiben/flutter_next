# Flutter Next Workspace

This workspace contains multiple Flutter packages:

- **animation_next**: A comprehensive Flutter animation package
- **flutter_next**: A Flutter package for faster UI development with responsiveness

## Shared Example

The example project is shared between both packages and located at `example_shared/`. To sync it to both package directories (required for pub.dev), run:

```bash
melos run sync_examples
```

Or use the script directly:

```bash
bash scripts/sync_examples.sh
```

## Development

### Setup

```bash
# Install dependencies
melos run all
```

### Running Examples

```bash
# Run animation_next example
cd animation_next/example
flutter run

# Run flutter_next example
cd flutter_next/example
flutter run
```

### Publishing

Before publishing to pub.dev, make sure to sync the examples:

```bash
melos run sync_examples
```

This ensures both packages have their `example/` directories properly set up for pub.dev.

## Structure

```
flutter_next/
├── example_shared/          # Shared example source
├── animation_next/          # Animation Next package
│   └── example/            # Synced from example_shared
├── flutter_next/           # Flutter Next package
│   └── example/            # Synced from example_shared
└── scripts/
    └── sync_examples.sh    # Script to sync examples
```

