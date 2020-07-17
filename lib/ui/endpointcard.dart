import 'package:coronatracker/app/services/api.dart';
import 'package:flutter/material.dart';

class EndPointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  EndPointCard({this.endpoint, this.value});

  static Map<Endpoint, String> _cardTitles ={
    Endpoint.cases:'Cases',
    Endpoint.casesSuspected :'Suspected cases',
    Endpoint.casesConfirmed : 'Confirmed cases',
    Endpoint.deaths : 'Deaths',
    Endpoint.recovered : 'Recovered',
  };


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  _cardTitles[endpoint],
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
