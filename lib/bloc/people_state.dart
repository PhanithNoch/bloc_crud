part of 'people_bloc.dart';

@immutable
abstract class PeopleState {}

class PeopleInitial extends PeopleState {

}

class PeopleLoadedState extends PeopleState {
 final List<Data> data;

PeopleLoadedState({this.data});

}

class PeopleCreateState extends PeopleState {
final bool status;

PeopleCreateState({this.status});
}
class PeopleDeleteState extends PeopleState {
final String status;

PeopleDeleteState({this.status});
}
class PeopleUpdateState extends PeopleState {
final bool state;

PeopleUpdateState({this.state});
}
