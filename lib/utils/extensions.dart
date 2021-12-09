import 'dart:ui';

extension ListExtension<T> on List<T> {
  List<T> copy() => this.toList();

  List<T> shuffled() {
    var it = this.copy();
    it.shuffle();
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
