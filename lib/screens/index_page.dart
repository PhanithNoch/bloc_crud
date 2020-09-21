import 'package:bloc_crud/bloc/people_bloc.dart';
import 'package:bloc_crud/models/people.dart';
import 'package:bloc_crud/screens/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<PeopleBloc, PeopleState>(builder: (context, state) {
      if (state is PeopleInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PeopleLoadedState) {
        return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              int id;
              String firstname;
              String lastname;
              String age;
              String active_date;
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Text(state.data[index].firstName),
                      foregroundColor: Colors.white,
                    ),
                    title: Text(state.data[index].firstName),
                    subtitle: Text(state.data[index].active_date),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Update',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePate(
                                    people: state.data[index],
                                  )))
                    },
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => {
                      id = state.data[index].id,
                      BlocProvider.of<PeopleBloc>(context)
                          .add(PeopleDeleteEvent(id: id)),
                      BlocProvider.of<PeopleBloc>(context)
                          .add(PeopleLoadingEvent()),
                    },
                  ),
                ],
              );
            });
      }
      return Center();
    }));
  }
}
