import 'dart:io';

import 'package:coronatracker/app/services/api.dart';
import 'package:coronatracker/repositories/data_repositories.dart';
import 'package:coronatracker/repositories/endpointsdata.dart';
import 'package:coronatracker/ui/endpointcard.dart';
import 'package:coronatracker/ui/lastupdatedstatusdate.dart';
import 'package:coronatracker/ui/showalertdialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndpointsData _endpointsData;

  Future<void> _updateData() async {
    try{
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }
    on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Check your Internet connection.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null ? _endpointsData.values[Endpoint.cases].date ?? '': null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('CoronaVirus Tracker'),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for(var endpoint in Endpoint.values)
            EndPointCard(
              endpoint: endpoint,
              value: _endpointsData != null ? _endpointsData.values[endpoint].value : null,
            )
          ],
        ),
      ),
    );
  }
}

