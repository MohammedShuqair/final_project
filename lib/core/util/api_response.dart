class ApiResponse<T> {
  ApiStatus status;
  T? data;
  String? message;

  ApiResponse.loading({this.message}) : status = ApiStatus.LOADING;
  ApiResponse.more({this.message, this.data}) : status = ApiStatus.MORE;
  ApiResponse.completed(this.data, {this.message})
      : status = ApiStatus.COMPLETED;
  ApiResponse.error({this.message}) : status = ApiStatus.ERROR;

  @override
  String toString() {
    return "Status : $status \n message : $message \n Data : $data";
  }
}

enum ApiStatus { LOADING, COMPLETED, ERROR, MORE }
