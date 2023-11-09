import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> boardState = List.filled(9, '');

  bool xTurn = true;

  void _onTileTap(int index) {
    if (boardState[index] == '') {
      setState(() {
        boardState[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => _onTileTap(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    boardState[index],
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
