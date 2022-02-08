List<String> prefixesList = ['xxl', 'xl', 'lg', 'md', 'sm', 'xs'];
List<String> prefixesReversedList = prefixesList.reversed.toList();
List<String> allPrefixList = ['xxl', 'xl', 'lg', 'md', 'sm', 'xs'];

double oneColumnRatio = 0.083333;
double gutterSize = 48.0;
int numberOfColumns = 12;

mixin Prefixes {
  static const String xxl = 'xxl';
  static const String xl = 'xl';
  static const String lg = 'lg';
  static const String md = 'md';
  static const String sm = 'sm';
}
mixin ArgPrefixType {
  static const String order = 'order';
  static const String col = 'col';
  static const String offset = 'offset';
}
