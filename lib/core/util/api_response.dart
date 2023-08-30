class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.loading({this.message}) : status = Status.LOADING;
  ApiResponse.completed(this.data, {this.message}) : status = Status.COMPLETED;
  ApiResponse.error({this.message}) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
