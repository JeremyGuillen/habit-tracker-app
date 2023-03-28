import 'package:habit_tracker/api/utils/flutter_store_controller.dart';
import 'package:http_interceptor/http_interceptor.dart';

class GuardInterceptor implements InterceptorContract {
  FlutterStore store = FlutterStore();
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers['Content-Type'] = "application/json";
    String? jwt = await store.getValue("jwt_token");
    if (jwt != null) {
      data.headers['Authorization'] = "Bearer $jwt";
    }
    print(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}
