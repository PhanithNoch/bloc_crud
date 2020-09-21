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
              String email;
              String phone;
              String city;
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      child: Text(state.data[index].city),
                      foregroundColor: Colors.white,
                    ),
                    title: Text(state.data[index].firstName),
                    subtitle: Text(state.data[index].email),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Update',
                    color: Colors.blue,
                    icon: Icons.edit,
                    onTap: () => {
                      id = state.data[index].id,
                      firstname = state.data[index].firstName,
                      lastname = state.data[index].lastName,
                      email = state.data[index].email,
                      phone = state.data[index].phone,
                      city = state.data[index].city,
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePate(
                                    peopleId: id,
                                    firstname: firstname,
                                    lastname: lastname,
                                    email: email,
                                    phone: phone,
                                    city: city,
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
