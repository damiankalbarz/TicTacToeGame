import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> boardState = List.filled(9, '');

  bool xTurn = true;
  bool gameFinished = false;

  void _onTileTap(int index) {
    if (!gameFinished && boardState[index] == '') {
      setState(() {
        boardState[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (boardState[combination[0]] != '' &&
          boardState[combination[0]] == boardState[combination[1]] &&
          boardState[combination[1]] == boardState[combination[2]]) {
        setState(() {
          gameFinished = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('Player ${boardState[combination[0]]} wins!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            );
          },
        );
        break;
      } else if (!boardState.contains('')) {
        setState(() {
          gameFinished = true;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('It\'s a tie!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: Text('Play Again'),
                ),
              ],
            );
          },
        );
        break;
      }
    }
  }

  void _resetGame() {
    setState(() {
      boardState = List.filled(9, '');
      gameFinished = false;
      xTurn = true;
    });
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
