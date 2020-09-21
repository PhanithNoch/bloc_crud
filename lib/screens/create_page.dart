import 'package:bloc_crud/bloc/people_bloc.dart';
import 'package:bloc_crud/screens/index_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/people.dart';

class CreatePage extends StatelessWidget {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
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
                controller: _firstnameController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "First Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _lastnameController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              TextField(
                controller: _emailController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: _phoneController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "Phone",
                ),
              ),
              TextField(
                controller: _cityController,
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                  hintText: "City",
                ),
              ),
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
                            firstName: _firstnameController.text,
                            lastName: _lastnameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            city: _cityController.text);
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
