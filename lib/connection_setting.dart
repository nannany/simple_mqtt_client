class ConnectionSetting {
  String host;
  String port;

  ConnectionSetting(this.host, this.port);

  ConnectionSetting.fromJson(Map<String, dynamic> json)
      : this.host = json['host'],
        this.port = json['port'];

  Map<String, dynamic> toJson() => {'host': host, 'port': port};
}
