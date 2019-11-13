import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:user/bloc/user_bloc.dart';
import 'package:user/model/user.dart';
import 'package:user/model/user_response.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primaryColor: Colors.yellow,
      textTheme: TextTheme(
          title: TextStyle(fontSize: 30, color: Colors.white),
          subtitle: TextStyle(fontSize: 20, color: Colors.white),
          body1: TextStyle(fontSize: 15, color: Colors.white)),
    ),
    home: UserWidget(),
  ));
}

class UserWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserWidgetState();
  }
}

class _UserWidgetState extends State<UserWidget> {
  @override
  void initState() {
    super.initState();
    bloc.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserResponse>(
      stream: bloc.subject.stream,
      builder: (context, AsyncSnapshot<UserResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildUserWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Container(
          width: 400,
          color: Colors.orange[600],
          child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Text(
            "Loading data from API...",
            style: Theme.of(context).textTheme.title,
          ),
          CircularProgressIndicator()
      ],
    ),
        ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Container(
      color: Colors.orange[600],
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Error occured: $error",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    ));
  }

  Widget _buildUserWidget(UserResponse data) {
    User user = data.results[0];
    return Center(
        child: Container(
      width: 400,
      color: Colors.orange[600],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(user.picture.large),
          ),
          Text(
            "${(user.name.first)} ${(user.name.last)}",
            style: Theme.of(context).textTheme.title,
          ),
          Text(user.email, style: Theme.of(context).textTheme.subtitle),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.street, style: Theme.of(context).textTheme.body1),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.city, style: Theme.of(context).textTheme.body1),
          Padding(
            padding: EdgeInsets.only(top: 5),
          ),
          Text(user.location.state, style: Theme.of(context).textTheme.body1),
        ],
      ),
    ));
  }
}
