extension StringExtension on String {
  // ------------------------------------------------------------------
  /// merubah huruf diawal kata pertama dalam kalimat menjadi capital
  // ------------------------------------------------------------------
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  // -----------------------------------------------------------
  /// merubah setiap huruf awal dalam kalimat menjadi capital
  // -----------------------------------------------------------
  String capitalizeEachWord() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) =>
            word.isEmpty ? word : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}

extension TerbilangExtension on int {
  String terbilang() {
    if (this == 0) return "nol";
    if (this < 0) return "minus ${(-this).terbilang()}";
    return _terbilang(this).trim();
  }

  String _terbilang(int n) {
    final satuan = [
      "",
      "satu",
      "dua",
      "tiga",
      "empat",
      "lima",
      "enam",
      "tujuh",
      "delapan",
      "sembilan",
      "sepuluh",
      "sebelas"
    ];

    if (n < 12) {
      return satuan[n];
    } else if (n < 20) {
      return "${_terbilang(n - 10)} belas";
    } else if (n < 100) {
      return "${_terbilang(n ~/ 10)} puluh ${_terbilang(n % 10)}";
    } else if (n < 200) {
      return "seratus ${_terbilang(n - 100)}";
    } else if (n < 1000) {
      return "${_terbilang(n ~/ 100)} ratus ${_terbilang(n % 100)}";
    } else if (n < 2000) {
      return "seribu ${_terbilang(n - 1000)}";
    } else if (n < 1000000) {
      return "${_terbilang(n ~/ 1000)} ribu ${_terbilang(n % 1000)}";
    } else if (n < 1000000000) {
      return "${_terbilang(n ~/ 1000000)} juta ${_terbilang(n % 1000000)}";
    } else if (n < 1000000000000) {
      return "${_terbilang(n ~/ 1000000000)} miliar ${_terbilang(n % 1000000000)}";
    } else {
      return "${_terbilang(n ~/ 1000000000000)} triliun ${_terbilang(n % 1000000000000)}";
    }
  }
}
