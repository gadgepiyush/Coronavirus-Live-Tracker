import 'package:coronatracker/app/services/api.dart';
import 'package:coronatracker/app/services/api_service.dart';
import 'package:coronatracker/repositories/endpointsdata.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  DataRepository({@required this.apiService});

  String _accessToken;

  Future<int> getEndpoint(Endpoint endpoint) async {
   return await _getDataRefreshingToken<int>(
      onGetData: () =>apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint),
   );
  }

  Future<EndpointsData> getAllEndpointData() async {
  return await _getDataRefreshingToken<EndpointsData>(
    onGetData: () => _getAllEndpointsData(),
  );
  }


  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
         _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    //this will get executed one by one
//    final cases = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases);
//    final casesSuspected = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesSuspected);
//    final casesConfirmed = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesConfirmed);
//    final deaths = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths);
//    final recovered = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered);

    // this will get executed parallelly
    final values = await Future.wait([
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);

    return EndpointsData( values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[4],
      }
    );
  }
}
