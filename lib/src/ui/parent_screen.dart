import 'package:flutter/material.dart';
import '../../abg_utils.dart';

Widget Function() getWebDialogBody = (){return Container();};

class ParentScreen extends StatefulWidget {
  final Widget child;
  final Widget waitWidget;
  const ParentScreen({Key? key, required this.child, required this.waitWidget}) : super(key: key);
  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

bool _firstRun = true;

class _ParentScreenState extends State<ParentScreen> {

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    redrawMainWindowInitialized = true;
    openDialog = _openDialog;
    closeDialog = _closeDialog;
    waitInMainWindow = _waits;
   // print("build redrawMainWindow=$hashCode");

    if (_firstRun){
      _firstRun = false;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // _redraw();
        redrawMainWindow();
      });
    }

    return Directionality(
        textDirection: direction,
        child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  closeAllPopups();
                  redrawMainWindow();
                },
                child: widget.child,
              ),

              showPopup(),

              getWebDialogBody(),

              if (_wait)
                Positioned.fill(
                  child: Center(child: Container(child: widget.waitWidget)),
                ),

                IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;},
                  color: Colors.grey,
                  backgroundColor: (aTheme.darkMode) ? Colors.black : Colors.white,
                  getBody: _getDialogBody,),
            ],
          )
        )
    );
  }

  double _show = 0;
  Widget Function() _getDialogBody = (){return Container();};

  _openDialog(Widget Function() getDialogBody){
    _getDialogBody = getDialogBody;
    _show = 1;
    // _redraw();
    redrawMainWindow();
  }

  _closeDialog(){
    _show = 0;
    // _redraw();
    redrawMainWindow();
  }

  bool _wait = false;
  _waits(bool value){
    _wait = value;
    // _redraw();
    redrawMainWindow();
  }

  // _redraw(){
  //   if (mounted)
  //     setState(() {
  //     });
  // }
}