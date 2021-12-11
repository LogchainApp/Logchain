import 'dart:ui';

typedef Comparator<T> = int Function(T, T);

extension ListExtension<T> on List<T> {
  List<T> copy() => this.toList();

  List<T> shuffled() {
    var it = this.copy();
    it.shuffle();
    return it;
  }

  List<T> sorted(Comparator comparator) {
    var it = this.copy();
    it.sort(comparator);
    return it;
  }
}

extension ColorExtension on Color {
  Color avgWith(Color other) {
    return Color.fromARGB(
      (this.alpha + other.alpha) ~/ 2,
      (this.red + other.red) ~/ 2,
      (this.green + other.green) ~/ 2,
      (this.blue + other.blue) ~/ 2,
    );
  }
}
