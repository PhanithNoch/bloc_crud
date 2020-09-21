import 'package:bloc_crud/bloc/people_bloc.dart';
import 'package:bloc_crud/models/people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePate extends StatefulWidget {
  int peopleId;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController activedateController = TextEditingController();
  UpdatePate({Data people}) {
    this.firstnameController.text = people.firstName;
    this.lastnameController.text = people.lastName;
    this.ageController.text = people.age;
    this.activedateController.text = people.active_date;
    this.peopleId = people.id;
  }

  @override
  _UpdatePateState createState() => _UpdatePateState();
}

class _UpdatePateState extends State<UpdatePate> {


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

  Data people;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: BlocListener<PeopleBloc, PeopleState>(
        listener: (context, state) {
          if (state is PeopleUpdateState) {
            if (state.state == true) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: new Text("Update Successfully!")));
            }
            Future.delayed(const Duration(milliseconds: 1000), () {
              Navigator.pop(context);
              BlocProvider.of<PeopleBloc>(context).add(PeopleLoadingEvent());
            });
          }
        },
        child: ListView(
          padding: EdgeInsets.only(right: 20, top: 5, left: 20),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: widget.firstnameController,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "First Name",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: widget.lastnameController,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              controller: widget.ageController,
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
                  SizedBox(width: 20.0,),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  people = new Data(
                      id: widget.peopleId,
                      firstName: widget.firstnameController.text,
                      lastName: widget.lastnameController.text,
                      age: widget.ageController.text,
                      active_date: selectedDate.toIso8601String());

                  BlocProvider.of<PeopleBloc>(context)
                      .add(PeopleUpdateEvent(people: people));
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
