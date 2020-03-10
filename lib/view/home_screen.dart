import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_mvvm_arch/base/base.dart';
import 'package:flutter_base_mvvm_arch/utils/toast.dart';
import 'package:flutter_base_mvvm_arch/utils/widget_utils.dart';
import 'package:flutter_base_mvvm_arch/viewModel/HomeProvide.dart';
import 'package:provider/provider.dart';

class HomeScreen extends PageProvideNode<HomeProvide> {
  HomeScreen(String title) : super(params: [title]);

  @override
  Widget buildContent(BuildContext context) {
    return _HomeContentScreen(mProvider);
  }
}

class _HomeContentScreen extends StatefulWidget {
  final HomeProvide provide;

  _HomeContentScreen(this.provide);

  @override
  State<StatefulWidget> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<_HomeContentScreen>
    with TickerProviderStateMixin<_HomeContentScreen>
    implements Presenter {
  HomeProvide mProvider;
  AnimationController _controller;
  Animation<double> _animation;

  static const ACTION_LOGIN = 'login';

  @override
  void initState() {
    super.initState();
    mProvider = widget.provide;
    _controller = AnimationController(
        vsync: this, duration: const Duration(microseconds: 300));
    _animation = Tween(begin: 295.0, end: 48.0).animate(_controller)
      ..addListener(() {
        mProvider.btnWidth = _animation.value;
      });
  }

  @override
  void dispose() {
    print('-------dispose-------');
    _controller.dispose();
    super.dispose();
  }

  @override
  void onClick(String action) {
    print("onClick:" + action);
    if (action == ACTION_LOGIN) {
      login();
    }
  }

  void login() {
    final subscription = mProvider.login().doOnListen(() {
      _controller.forward();
    }).doOnDone(() {
      _controller.reverse();
    }).listen(
      (_) {
        Toast.show('Login success', context, type: Toast.SUCCESS);
      },
      onError: (e) {
        dispatchFailure(context, e);
      },
    );

    mProvider.addSubscription(subscription);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(mProvider.title),
        ),
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.black),
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.person),
                      labelText: 'Username'),
                  autofocus: false,
                  onChanged: (value) => mProvider.username = value,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  autofocus: false,
                  textAlign: TextAlign.start,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                _buildLoginButtonProvide(),
                const Text(
                  'Response: ',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                    child: Container(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Selector<HomeProvide, String>(
                    selector: (_, data) => data.response,
                    builder: (context, value, child) {
                      return Text(value);
                    },
                  ),
                ))
              ],
            )),
      ),
    );
  }

  Consumer<HomeProvide> _buildLoginButtonProvide() {
    return Consumer<HomeProvide>(builder: (context, value, child) {
      return CupertinoButton(
        onPressed: value.loading ? null : () => onClick(ACTION_LOGIN),
        pressedOpacity: 0.8,
        child: Container(
          alignment: Alignment.center,
          width: value.btnWidth,
          height: 48.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              gradient: LinearGradient(
                  colors: [Color(0xFF686CF2), Color(0xFF0E5CFF)]),
              boxShadow: [
                BoxShadow(
                    color: Color(0x4D5E56FF),
                    offset: Offset(0.0, 4.0),
                    blurRadius: 13.0)
              ]),
          child: _buildLoginChild(value),
        ),
      );
    });
  }

  Widget _buildLoginChild(HomeProvide value) {
    if (value.loading) {
      return const CircularProgressIndicator();
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Github Login',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
      );
    }
  }
}
