import 'package:coronatracker/app/services/api.dart';
import 'package:coronatracker/repositories/data_repositories.dart';
import 'package:coronatracker/repositories/endpointsdata.dart';
import 'package:coronatracker/ui/endpointcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndpointsData _endpointsData;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoronaVirus Tracker'),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            for(var endpoint in Endpoint.values)
            EndPointCard(
              endpoint: endpoint,
              value: _endpointsData != null ? _endpointsData.values[endpoint] : null,
            )
          ],
        ),
      ),
    );
  }
}

