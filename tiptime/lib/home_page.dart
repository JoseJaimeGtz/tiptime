import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int? currentRadio;
  double tip = 0.00;
  bool _validate = false;
  bool isSwitched = false;
  var costOfServiceController = TextEditingController();

  var radioGroup = {
    0: "Amazing (20%)",
    1: "Good (18%)",
    2: "Okay (15%)",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            leading: Icon(Icons.store, color: Color.fromARGB(255, 5, 126, 9)),
            title: Padding(
              padding: EdgeInsets.only(right: 165),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: costOfServiceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Cost of service"),
                  errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.room_service, color: Color.fromARGB(255, 5, 126, 9)),
            title: Text("How was the service?"),
          ),
          Column(
            children: radioGroupGenerator(),
          ),
          ListTile(
            horizontalTitleGap: 0,
            leading: Icon(Icons.call_made, color: Color.fromARGB(255, 5, 126, 9)),
            title: Text("Round up tip"),
            trailing: Switch(
              activeColor: Colors.blue,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 75, right: 4),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "CALCULATE", 
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () {
                _tipCalculation();
                setState(() {
                  costOfServiceController.text.isEmpty ? _validate = true : _validate = false;
                });
              },
              color: Color.fromARGB(255, 5, 126, 9),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, right: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tip amount: \$${tip.toStringAsFixed(2)}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _tipCalculation() {
    if (costOfServiceController.text.isEmpty) {
      tip = 0.00;
    } else {
      tip = double.parse(costOfServiceController.text);
      if (currentRadio == 0) {
        tip *= 1.20;
      } else if (currentRadio == 1) {
        tip *= 1.18;
      } else if (currentRadio == 2) {
        tip *= 1.15;
      }
      if (isSwitched) {
        tip = tip.ceilToDouble();
      }
    }
    return tip;
  }

  radioGroupGenerator() {
    return radioGroup.entries
      .map(
        (radioElement) => Container(
          padding: EdgeInsets.only(left: 35),
          child: ListTile(
            leading: Radio(
              activeColor: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: radioElement.key,
              groupValue: currentRadio,
              onChanged: (int? selected) {
                currentRadio = selected;
                setState(() {});
              },
            ),
            title: Transform.translate(
              offset: Offset(-16, 0),
              child: Text("${radioElement.value}"),
            ),
          ),
        ),
      )
      .toList();
  }
}
