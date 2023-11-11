class Record {
  String body;

  Record(this.body);
  Record.from(String dateTime, String substance, {String? amount})
      : body = "$dateTime | $substance${amount != null ? " $amount" : ""}";

  Map<String, dynamic> toMap() {
    return {
      'body': body,
    };
  }

  @override
  String toString() {
    return 'Record{body: $body}';
  }
}
