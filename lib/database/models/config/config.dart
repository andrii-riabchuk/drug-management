const String CREATE_CONFIGS_TABLE =
    'CREATE TABLE Configs(key TEXT PRIMARY KEY NOT NULL, value TEXT)';

class Config {
  String key;
  String value;

  Config.literally(this.key, this.value);
  Config(Map<String, dynamic> map)
      : key = map['key'] as String,
        value = map['value'] as String;

  Map<String, dynamic> toMap() {
    return {'key': key, 'value': value};
  }
}
