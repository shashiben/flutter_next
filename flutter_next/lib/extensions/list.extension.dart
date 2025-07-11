extension ListExtension<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
