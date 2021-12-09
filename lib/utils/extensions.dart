extension ListExtension<T> on List<T> {
  List<T> copy() => this.toList();

  List<T> shuffled() {
    var it = this.copy();
    it.shuffle();
    return it;
  }
}
