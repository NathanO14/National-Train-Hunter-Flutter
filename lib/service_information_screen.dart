import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:national_train_hunter/cubit/service_information_cubit.dart';
import 'package:national_train_hunter/model/service_calling_point.dart';
import 'package:national_train_hunter/model/service_information.dart';

class ServiceInformationScreen extends StatefulWidget {
  final String _rid;

  ServiceInformationScreen(this._rid);

  @override
  _ServiceInformationScreenState createState() =>
      _ServiceInformationScreenState();
}

class _ServiceInformationScreenState extends State<ServiceInformationScreen> {
  ServiceInformation _serviceInformation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ServiceInformationCubit>(context)
        .getServiceDetails(widget._rid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Information'),
      ),
      body: BlocConsumer<ServiceInformationCubit, ServiceInformationState>(
        listener: (context, state) {
          if (state is ServiceInformationLoaded) {
            setState(() {
              _serviceInformation = state.serviceInformation;
            });
          }
        },
        builder: (context, state) {
          return Container(
            child: (state is ServiceInformationLoading)
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: _serviceInformation != null
                        ? _serviceInformation.callingPoints.length
                        : 0,
                    itemBuilder: (BuildContext context, int index) {
                      ServiceCallingPoint callingPoint =
                          _serviceInformation.callingPoints[index];
                      return Text(
                          '${callingPoint.scheduledDepartureTime} - ${callingPoint.stationName}');
                    },
                  ),
          );
        },
      ),
    );
  }
}
