import '../../../data/usecases/use_cases.dart';
import '../../../domain/usecases/usecases.dart';
import '../http/http.dart';


AddAccount makeRemoteAddAccount() {
  
  return RemoteAddAcount(
    httpClient: makeHttpAdapter(),
      url: makeApiUrl('signup'),
  );

}