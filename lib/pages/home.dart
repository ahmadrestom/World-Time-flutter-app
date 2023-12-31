import 'package:flutter/material.dart';

class Home extends StatefulWidget {  const Home({Key? key}) : super(key: key);

@override
State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) { //here you receive the actual arguments sent from the loading screen


    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map; //this will get you the arguments sent by loading page
    print(data);

    //set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Images/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () async{
                      //when clicking on edit location, it will stop until you choose the country, the it will return the data
                      //to the variable result
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag']
                        };
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    icon: const Icon(
                      Icons.edit_location,
                      color: Colors.grey,
                    ),
                    label: const Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['location'], style: const TextStyle(fontSize: 28.0, letterSpacing: 2.0, color: Colors.white),)
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}