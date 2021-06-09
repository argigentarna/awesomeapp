class Response {
  final int rc;
  // final String status;
  final dynamic data;

  Response({
    this.rc,
    // this.status,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rc'] = this.rc;
    // data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
