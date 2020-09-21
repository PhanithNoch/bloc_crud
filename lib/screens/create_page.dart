import 'package:bloc_crud/bloc/people_bloc.dart';
import 'package:bloc_crud/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/people.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController activedateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    Data people;
    return Scaffold(
        appBar: AppBar(
          title: Text('Create People'),
        ),
        body: BlocListener<PeopleBloc, PeopleState>(
          listener: (context, state) {
            if (state is PeopleCreateState) {
              if (state.status == true) {
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text("People Created !")));
                Navigator.pop(context);
                BlocProvider.of<PeopleBloc>(context).add(PeopleLoadingEvent());
              }
            }
          },
          child: ListView(
            padding: EdgeInsets.only(right: 20, top: 5, left: 20),
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: firstnameController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: lastnameController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              TextField(
                controller: ageController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Age",
                ),
              ),
              Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text("${selectedDate.toLocal()}".split(' ')[0]),
                    SizedBox(
                      width: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ]),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        people = new Data(
                            firstName: firstnameController.text,
                            lastName: lastnameController.text,
                            age: ageController.text,
                            active_date: selectedDate.toString());
                        BlocProvider.of<PeopleBloc>(context)
                            .add(PeopleCreateEvent(people: people));
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
