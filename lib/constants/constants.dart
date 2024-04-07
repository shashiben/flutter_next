/// List of grid prefixes.
List<String> gridPrefixes = <String>['xxl', 'xl', 'lg', 'md', 'sm', 'xs'];

/// Reversed list of grid prefixes.
List<String> reversedGridPrefixes = gridPrefixes.reversed.toList();

/// List of all prefixes.
List<String> allPrefixes = <String>['xxl', 'xl', 'lg', 'md', 'sm', 'xs'];

/// Ratio for one column.
double oneColumnRatio = 0.083333;

/// Size of the gutter.
double gutterSize = 48.0;

/// Number of columns in the grid.
int numberOfColumns = 12;

/// Mixin for argument prefix types.
mixin ArgPrefixType {
  static const String order = 'order';
  static const String col = 'col';
  static const String offset = 'offset';
}
