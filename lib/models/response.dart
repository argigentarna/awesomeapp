class Response {
  final int rc;
  final String message;
  final dynamic data;

  Response({
    this.rc,
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
