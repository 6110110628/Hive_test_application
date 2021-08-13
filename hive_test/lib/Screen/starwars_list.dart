import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Help/starwars_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StarwarsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StarwarsListState();
}

class _StarwarsListState extends State<StarwarsList> {
  var box = Hive.box('starwars');
  late bool _hasMore;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  final int _defaultPeoplePerPageCount = 10;
  final StarwarsRepo _repo;
  late List<People> _people;
  final int _nextPageThreshold = 5;

  _StarwarsListState() : _repo = new StarwarsRepo();

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _people = [];
    fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    if (box.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
            child: InkWell(
          onTap: () {
            setState(() {
              _loading = true;
              _error = false;
              fetchPeople();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Error while loading people, tap to try agin"),
          ),
        ));
      }
    } else {
      return ListView.builder(
          itemCount: box.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == box.length - _nextPageThreshold) {
              if (_pageNumber < 10) {
                fetchPeople();
              }
            }
            if (index == box.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      _loading = true;
                      _error = false;
                      fetchPeople();
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading people, tap to try agin"),
                  ),
                ));
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              }
            }
            if (index == 16) index++; //index17 is Null
            final People people = box.get(index + 1);
            return Card(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.pink.shade100,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        foregroundImage: CachedNetworkImageProvider(
                            'https://starwars-visualguide.com/assets/img/characters/${people.no}.jpg'),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text('Name : ${people.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(
                              'Height : ${people.height}     Mass : ${people.mass}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14)),
                          Text(
                              'Gender : ${people.gender}     Birth of Year : ${people.birthYear}',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 14)),
                        ],
                      )),
                ],
              ),
            );
          });
    }
    return Container();
  }

  Future<void> fetchPeople() async {
    try {
      var people = await _repo.fetchPeople(page: _pageNumber);
      List<People> fetchedPeople = people;
      setState(() {
        _hasMore = fetchedPeople.length == _defaultPeoplePerPageCount;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _people.addAll(fetchedPeople);
      });
    } catch (e) {
      if (this.mounted) {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    }
  }
}
