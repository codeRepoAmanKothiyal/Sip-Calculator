import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SIP Calculator",
    home: SIPForm(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
          .copyWith(secondary: Colors.green, brightness: Brightness.dark),
    ),
  ));
}

class SIPForm extends StatefulWidget {
  const SIPForm({super.key});

  @override
  State<StatefulWidget> createState() => _SIPFormState();
}

class _SIPFormState extends State<SIPForm> {

  var _formKey = GlobalKey<FormState>();
    final _minimumPadding = 5.0;
  var _currencies = ["Other", "Rupees", "Dollar", "pounds", "Rubals"];

  var _currentItemSelected = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termConteroller = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("SIP Calculator"),
      ),
      body: Form(
        key:  _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (value){
                        if(value ==""){
                          return "please enter principal Amount";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'principal',
                          hintText: "Enter Prinvipal Amount e.g :5000",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (value){
                        if(value ==""){
                          return "please enter principal Amount";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'ROI',
                          hintText: "Enter ROI in %",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termConteroller,
                              validator: (value){
                                if(value ==""){
                                  return "please enter principal Amount";
                                }
                              },

                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: "No. of years",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              "Calculate",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState!.validate()){
                                this.displayResult = _calculateTotalReturn();
                              }});
                            },
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text(
                              "Reset",
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    this.displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termConteroller.text);

    double totalAmountPayable = principal + (principal * roi * term) / 100;

    String result =
        "After $term year your investment will be $totalAmountPayable $_currentItemSelected";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termConteroller.text = "";
    displayResult = "";
    _currentItemSelected = _currencies[0];
  }
}
