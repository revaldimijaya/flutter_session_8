import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:session_8/home.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage>{

  var ctrlUsername = new TextEditingController();
  var ctrlPassword = new TextEditingController();

  String selectedCountry;
  List countries = [
    "Indonesia",
    "Japan",
    "Korea",
    "Thailand",
    "Singapore"
  ];

  int radioGroup = 0;
  String selectedGender;

  bool enableAds = false;

  DateTime dob;

  double sliderValue = 0;

  bool terms = false;

  AlertDialog createAlert(String text, String username){
    Widget noButton = TextButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes"),
      onPressed:  () {
        Navigator.push(context, MaterialPageRoute(builder: (builder){
          return HomePage(username);
        }));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Confirmation Dialog"),
      content: Text(text),
      actions: [
        noButton,
        yesButton,
        
      ],
    );

    return alert;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('Register')
      ),
      body: Builder(builder: (BuildContext ctx){
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top:25),
                child: Text('Welcome to Flutter'),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(decoration: InputDecoration(hintText: 'Username'), controller: ctrlUsername,),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Password'), 
                  controller: ctrlPassword,
                  obscureText: true,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: DropdownButton(
                  hint: Text('Select Country'),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  isExpanded: true,
                  value: selectedCountry,
                  items: countries.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem)
                    );
                  }).toList(), 
                  onChanged: (value) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      selectedCountry = value;
                    });
                  }
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Select Gender'),
                    Row(
                      children: [
                        Radio(
                          value: 1, 
                          groupValue: radioGroup,
                          onChanged: (value){
                            setState(() {
                              radioGroup = value;
                              selectedGender = "Male";
                            });
                          }
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Text('Male')
                      ]
                    ),
                    
                    Row(
                      children: [
                        Radio(
                          value: 2, 
                          groupValue: radioGroup,
                          onChanged: (value){
                            setState(() {
                              radioGroup = value;
                              selectedGender = "Female";
                            });
                          }
                        ),
                        Text('Female')
                      ]
                    ),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),

                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(dob == null ? 'Select Date of Birth' : dob.toString().split(" ")[0]),
                    ),
                    RaisedButton.icon(
                      icon: Icon(Icons.calendar_today),
                      label: Text('Choose Date'),
                      onPressed: () {
                        showDatePicker(
                          context: context, 
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(1990), 
                          lastDate: DateTime.now()
                        ).then((date){
                          setState(() {
                            dob = date;
                          });
                        });

                      },
                    )
                  ]
                )
                
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text('Showing Advertising'),
                    Switch(
                      value: enableAds,
                      onChanged: (value) {
                        setState(() {
                          enableAds = value;
                        });
                      },
                      activeTrackColor: Colors.lightBlueAccent,
                      activeColor: Colors.blue,
                    )

                  ],
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Slider(
                      value: sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: sliderValue.round().toString(),
                      onChanged: (value){
                        setState(() {
                          sliderValue = value;
                        });
                      }
                    ),
                    Text('Remaining Free Storage (%)')
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Checkbox(
                      value: terms, 
                      onChanged: (bool value){
                        setState(() {
                          terms = value;  
                        });
                      }
                    ),
                    Text('I agree to Terms of Service and Privacy Policy')
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: RaisedButton(
                  child: Text('Register'),
                  onPressed: (){
                    if(ctrlUsername.text == ""){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Username is empty'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(ctrlPassword.text == ""){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Password is empty'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(ctrlPassword.text.length < 5){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Length of password must be more than equals 5'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(selectedCountry == null){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Country must be selected'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(selectedGender == null){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Gender must be selected'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(dob == null){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Date of Birth must be selected'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if((dob.difference(DateTime.now()).inDays/365).round().abs() < 17){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Age must be above or equals to 17'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }
                    if(terms == false){
                      Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Terms and Privacy Policy must be checked'), backgroundColor: Colors.redAccent)
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (context) {
                        return createAlert('Are you sure want to create an account ?', ctrlUsername.text);
                      }
                    );
                  },
                )
              ),
              
            ],
          )
        );
      }),
    );
    
  }
}