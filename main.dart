import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:torch_light/torch_light.dart';
void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Light',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flash Light'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  Future <void> TorchLightOn()
  async {
    try
        {
          await TorchLight.enableTorch();
        }
      on EnableTorchExistentUserException  catch(e)
      {
        print("Camera In Use : $e");
        /*
        showDialog(
          context: context,
          builder: (context)
            {
              return Container(
                child: AlertDialog(
                  title: Text('Camera In Use'),
                  actions:
                  [
                    TextButton(
                      child: Text('OK'),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
         */
      }
    on EnableTorchNotAvailableException  catch(e)
    {
      print("Torch Not Available :  $e");
      /*
      showDialog(
          context: context,
          builder: (context)
          {
            return Container(
              child: AlertDialog(
                title: Text('Torch Not Available'),
                actions:
                [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
       */
    }
    on EnableTorchException  catch(e)
    {
      print("Something Went Wrong :  $e");
      /*
      showDialog(
          context: context,
          builder: (context)
          {
            return Container(
              child: AlertDialog(
                title: Text('Something Went Wrong'),
                actions:
                [
                  TextButton(
                    child: Text('OK'),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          });
       */
    }
  }
  Future <void> TorchLightOff()
  async {
    try
    {
      await TorchLight.disableTorch();

    }
    catch(e)
    {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the shadow
        title: Text(widget.title,
        style: TextStyle(
          fontFamily: 'MainFont',
          fontWeight: FontWeight.bold,
          fontSize: 40,
          color: Colors.pinkAccent,
        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child : Column(
          children:
          [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('Assets/LIGHT.jpg'),
                  radius: 100,
                ),
              ),
            ),
            LiteRollingSwitch(
              colorOff: Colors.red,
              colorOn: Colors.green,
              iconOn: CupertinoIcons.lightbulb_fill,
              iconOff: CupertinoIcons.lightbulb_slash,
              textOff: "OFF",
              textOn: "ON",
              onChanged: (val)
              {
                print(val);
                if(val)
                {
                  TorchLightOn();
                }
                else
                {
                  TorchLightOff();
                }
              },
              onTap:(val)
              {},
              onDoubleTap:()
              {},
              onSwipe: ()
              {},
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
      bottomNavigationBar: BottomAppBar(
        child: Text(
          '\t \t \t \t \t RAMZAN',
           style: TextStyle(
             fontFamily: 'MainFont',
             fontWeight: FontWeight.bold,
             fontSize: 40,
             color: Colors.black,
           ),
          ),
         color: Colors.grey,
        height:68,
      ),
    );
  }
}
