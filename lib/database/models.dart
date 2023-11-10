class Record {
  final int id;
  final String body;

  const Record(this.id, this.body);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'body': body,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, body: $body}';
  }
}
