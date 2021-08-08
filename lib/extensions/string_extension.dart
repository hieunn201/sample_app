extension StringExtension on String {
  static RegExp _replaceArgRegex = RegExp(r'{}');
  bool get isNullOrEmpty => this == null || this.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrWhiteSpace => this.isNullOrEmpty || this.trim().isEmpty;

  String arguments(List<dynamic> args) {
    if (args == null || args.isEmpty || this == null) return this;

    String res = this;

    args.forEach((value) => res = res.replaceFirst(_replaceArgRegex, '$value'));

    return res;
  }

  String get formatCurrency {
    if (this.isNullOrWhiteSpace) return '';
    return '\$ $this';
  }

  String closureFormat() => '($this)'.trim();
}
