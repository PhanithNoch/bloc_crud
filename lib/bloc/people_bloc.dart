import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_crud/models/people.dart';
import 'package:meta/meta.dart';
import '../services/rest_api.dart';
part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleBloc()
      : super(
          PeopleInitial(),
        );

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    RestAPI restapi = RestAPI();

    try {
      if (event is PeopleLoadingEvent) {
        var result = await restapi.getPeople();
        print(result);
        yield PeopleLoadedState(data: result.data);
      } else if (event is PeopleCreateEvent) {
        var response = await restapi.createPeople(event.people);
print("state in Bloc $response");
        yield PeopleCreateState(status: response);
      }
      else if(event is PeopleUpdateEvent){

        var response = await restapi.updatePeople(event.people);
        print(response.toString());
        yield PeopleUpdateState(state:response);
      }
      else if(event is PeopleDeleteEvent)
        {
          var response = await restapi.deletePeople(event.id);
          print(event.id);
          yield PeopleDeleteState(status: response.toString());
        }
    } catch (ex) {
      print(ex);
    }
  }
}
