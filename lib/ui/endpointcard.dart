import 'package:coronatracker/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData{
  final String title;
  final String assetName;
  final Color color;

  EndpointCardData({this.title, this.assetName, this.color});
}


class EndPointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  EndPointCard({this.endpoint, this.value});

  static Map<Endpoint, EndpointCardData> _cardData ={
    Endpoint.cases: EndpointCardData(title: 'Cases', assetName: 'assets/count.png',color: Color(0xFFFFF492)),
    Endpoint.casesSuspected :EndpointCardData(title: 'Suspected cases', assetName: 'assets/suspect.png',color: Color(0xFFEEDA28)),
    Endpoint.casesConfirmed : EndpointCardData(title: 'Confirmed cases', assetName: 'assets/fever.png',color: Color(0xFFE99600)),
    Endpoint.deaths : EndpointCardData(title: 'Deaths', assetName: 'assets/death.png',color: Color(0xFFE40000)),
    Endpoint.recovered : EndpointCardData(title: 'Recovered', assetName: 'assets/patient.png',color: Color(0xFF70A901)),
  };

String get formattedValue{
  if(value == null){
    return '';
  }
  return NumberFormat("##,##,##,##,##,##,###").format(value);
}
  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData.title,
                style: Theme.of(context).textTheme.headline5.copyWith(color: cardData.color),

              ),

              SizedBox(
                height: 4,
              ),

              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(cardData.assetName,color: cardData.color,),
                    Text(
                      formattedValue,
                      style: Theme.of(context).textTheme.headline4.copyWith(color: cardData.color),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
