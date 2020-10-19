import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
        return ListTile(
          title: (Text(pair.asPascalCase, style: TextStyle(fontSize: 16.0))),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('Saved WordPairs')
        ),
        body: ListView(children: divided,),
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: _buildList(),
    );
  }

  final __randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();

        final index = item ~/ 2;

        if (index >= __randomWordPairs.length) {
          __randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(__randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final _alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18.0)),
        trailing: Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: _alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (_alreadySaved) {
              _savedWordPairs.remove(pair);
            } else {
              _savedWordPairs.add(pair);
            }
          });
        });
  }
}
