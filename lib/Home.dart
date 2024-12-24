import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


List <String> list = [];


TextEditingController messagerController = TextEditingController();
StreamsSocket streamSocket = StreamsSocket();



  
Stream<int> generateNumber()async*{

while(true){

await Future.delayed(Duration(seconds:2));
print('akash');

yield DateTime.now().second;
}

} 

@override
  void initState() {


    super.initState();

list.add('shaban');
streamSocket.addResponse(list);


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('future function'.toUpperCase()),
          
    
          backgroundColor: Colors.green,
          centerTitle: true,
          foregroundColor: Colors.white,
          
        ),
    
    
    
    
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(stream: streamSocket.getResponse, builder: (context, AsyncSnapshot<List<String>> snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                else if( snapshot.connectionState == ConnectionState.active || 
                  snapshot.connectionState == ConnectionState.done
                )
  {
    if(snapshot.hasError){
      return Text (snapshot.error.toString());
    }
    else if(snapshot.hasData){
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index){
         return Text(snapshot.data![index].toString());

         
        },
      );
    }
    else
    {
      return Text('something went wrong');
    }

  }




              return Text(snapshot.data.toString());
            }
            ),
         Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: messagerController,
                decoration: InputDecoration(hintText: 'enter message'),
              
              
              ),
            ),
            IconButton(onPressed: (){

              list.add(messagerController.text.toString());
              streamSocket.addResponse(list);
            }, icon: Icon(Icons.send))
          ],
         )
         
          ],
        )


        );
  }
}



class StreamsSocket {

  final _stream = StreamController<List<String>>.broadcast();

    void Function (List <String>) get addResponse => _stream.sink.add; 

      Stream<List<String>> get getResponse => _stream.stream.asBroadcastStream();

}