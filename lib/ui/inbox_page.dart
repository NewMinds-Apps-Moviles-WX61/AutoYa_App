import 'dart:io';

import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('gerard_design'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
              ],
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    title: Text('Your service has been finished'),
                  ),
                  ElevatedButton(
                    onPressed: () {}, child: Text("Pay"),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    title: Text('The card owner has requested to end this service'),
                  ),
                  ElevatedButton(
                    onPressed: () {}, child: Text("Details"),
                  ),
                ],
              ),
            ),
            Card(
              child:
              Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(child: Icon(Icons.account_circle_rounded),),
                      Expanded(child: Text('gerard_design'),),
                      Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Message"),),
                      ),
                    ],
                  ),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                ],
              ),
            ),
            Text('Current fee of service'),
            TextFormField(
              decoration: InputDecoration(
                hintText:'PEN',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),

              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Request Change'))
          ],
        ),
      ),
    );
  }
}
