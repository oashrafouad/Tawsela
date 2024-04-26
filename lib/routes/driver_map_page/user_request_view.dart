import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawsela_app/models/bloc_models/driver_map_bloc/driver_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google%20map_states.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_bloc.dart';
import 'package:tawsela_app/models/bloc_models/google_map_bloc/google_map_events.dart';
import 'package:tawsela_app/models/data_base.dart';

class UserRequestListView extends StatelessWidget {
  const UserRequestListView({super.key});

  @override
  Widget build(BuildContext context) {
    late UberDriverState uberDriverProvider;
    if (BlocProvider.of<UberDriverBloc>(context).state is UserErrorState) {
      uberDriverProvider = uberLastState;
    } else {
      uberDriverProvider =
          BlocProvider.of<UberDriverBloc>(context).state as UberDriverState;
    }
    return ListView.builder(
      itemCount: uberDriverProvider.passengerRequests.isEmpty
          ? 0
          : uberDriverProvider.passengerRequests.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 238, 230, 230),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Information'),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                  content: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                          ),
                          Text(
                              'name: ${uberDriverProvider.passengerRequests[index].passengerName}'),
                          Text(
                              'location: ${uberDriverProvider.passengerRequests[index].currentLocationDescription}'),
                          Text(
                              'destination: ${uberDriverProvider.passengerRequests[index].destinationDescription}')
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          style: ListTileStyle.list,
          title: Text(userRequests[index].passengerName),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (uberDriverProvider.acceptedRequest == null) {
                      BlocProvider.of<UberDriverBloc>(context).add(
                          AcceptPassengerRequest(
                              passengerRequest: userRequests[index]));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  Text('You can not accept more than one trip'),
                            );
                          });
                    }
                  },
                  child: const Text(
                    'accept',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )),
              const SizedBox(
                width: 5,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    BlocProvider.of<UberDriverBloc>(context).add(
                        RejectPassengerRequest(
                            passengerRequest: userRequests[index]));
                  },
                  child: const Text('reject',
                      style: TextStyle(color: Colors.white, fontSize: 14)))
            ],
          ),
        ),
      ),
    );
  }
}
