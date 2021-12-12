import 'dart:math';
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

extension StringExtension on String {
  bool isSubsequence(String other) {
    if (this.length == 0) {
      return true;
    }

    if (other.length == 0) {
      return false;
    }

    var result = "";
    for (final char in other.runes) {
      if (String.fromCharCode(char) == this[result.length]) {
        result += String.fromCharCode(char);
      }

      if (result == this) {
        return true;
      }
    }
    return false;
  }

  int maxCommonSubsequence(String other) {
    int n = this.length, m = other.length;
    List<List<int>> dp =
        List.generate(n + 1, (index) => List.generate(m + 1, (index) => 0));
    for (var i = 0; i <= n; ++i) {
      for (var j = 0; j <= m; ++j) {
        if (i == 0 || j == 0) {
          dp[i][j] = 0;
        } else if (this[i - 1] == other[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1] + 1;
        } else {
          dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]);
        }
      }
    }

    return dp[n][m];
  }
}
