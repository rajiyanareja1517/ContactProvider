import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../provider/platform_provider.dart';

class HomeIOSPage extends StatefulWidget {
  const HomeIOSPage({super.key});

  @override
  State<HomeIOSPage> createState() => _HomeIOSPageState();
}

class _HomeIOSPageState extends State<HomeIOSPage> {
  late TextEditingController? textController;
  String text = "";

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'initial text');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text("Copntacts"),
          leading: CupertinoButton(
            child: Icon(CupertinoIcons.infinite),
            onPressed: () {
              Provider.of<PlatformProvider>(context, listen: false)
                  .setIsIos();
            },
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchTextField(
              fieldValue: (String value) {
                setState(() {
                  text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.fieldValue,
  });

  final ValueChanged<String> fieldValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: (String value) {
        fieldValue('The text has changed to: $value');
      },
      onSubmitted: (String value) {
        fieldValue('Submitted text: $value');
      },
    );
  }
}
