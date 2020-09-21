import 'package:bloc_crud/bloc/people_bloc.dart';
import 'package:bloc_crud/models/people.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePate extends StatelessWidget {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  int peopleId;

  UpdatePate({peopleId, firstname, lastname, email, phone, city}) {
    this.firstnameController.text = firstname;
    this.lastnameController.text = lastname;
    this.emailController.text = email;
    this.phoneController.text = phone;
    this.cityController.text = city;
    this.peopleId = peopleId;

    print(this.firstnameController.text);
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
              controller: emailController,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: phoneController,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "Phone",
              ),
            ),
            TextField(
              controller: cityController,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "City",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                color: Colors.blue,
                onPressed: () {
                  people = new Data(
                      id: peopleId,
                      firstName: firstnameController.text,
                      lastName: lastnameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      city: cityController.text);

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
