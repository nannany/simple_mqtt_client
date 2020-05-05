class ConnectionSetting {
  String host;
  String port;
  String name;

  ConnectionSetting(this.host, this.port, this.name);

  ConnectionSetting.fromJson(Map<String, dynamic> json)
      : this.host = json['host'],
        this.port = json['port'],
        this.name = json['name'];

  Map<String, dynamic> toJson() => {'host': host, 'port': port, 'name': name};
}
