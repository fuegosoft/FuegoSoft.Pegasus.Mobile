import 'package:flutter/material.dart';
import 'package:fuegosoft_mobile/blocs/bloc.dart';
import 'package:fuegosoft_mobile/utils/utils.dart';

class PerformRegister extends StatefulWidget {
  final BuildContext context;
  PerformRegister({Key key, this.context}) : super(key: key);

  _PerformRegisterState createState() => _PerformRegisterState();

  Widget _performCreateUser(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      color: Colors.black54.withOpacity(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        valueColor:
            AlwaysStoppedAnimation<Color>(getColor(ColorList.WhiteCream, 1.0)),
      ),
    );
  }
}

class _PerformRegisterState extends State<PerformRegister> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: widget._performCreateUser(context),
      bloc: UserBloc(),
    );
  }
}
