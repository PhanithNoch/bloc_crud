part of 'people_bloc.dart';

@immutable
class PeopleEvent {}
class PeopleLoadingEvent extends PeopleEvent{}
class PeopleLoadedEvent extends PeopleEvent {}
class PeopleCreateEvent extends PeopleEvent {
final Data people;

PeopleCreateEvent({this.people});
}
class PeopleUpdateEvent extends PeopleEvent {
  final Data people;

  PeopleUpdateEvent({this.people});
}
class PeopleDeleteEvent extends PeopleEvent {
 final int id;

 PeopleDeleteEvent({this.id});
}
