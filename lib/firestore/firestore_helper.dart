import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entertainmenttracker/model/movie.dart';
import 'package:entertainmenttracker/model/series.dart';
import 'package:entertainmenttracker/screens/watchlist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirestoreHelper {
  static final _firestore = Firestore.instance;
  static final _auth = FirebaseAuth.instance;

  static void addMovieToFirestore(
      Movie movie, String addToList, BuildContext context) {
    _firestore
        .collection(addToList)
        .where('id', isEqualTo: movie.id)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      if (snapshot.documents.length == 0) {
        _firestore.collection(addToList).add({
          'id': movie.id,
          'type': movie.type,
          'timestamp': Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
        });
        _firestore
            .collection('movies')
            .where('id', isEqualTo: movie.id)
            .getDocuments()
            .then((QuerySnapshot snapshot) {
          if (snapshot.documents.length == 0) {
            _firestore.collection('movies').add({
              'id': movie.id,
              'title': movie.title,
              'poster_path': movie.posterPath,
              'vote_average': movie.voteAverage,
              'overview': movie.overview,
              'type': movie.type,
//              'timestamp': movie.timeStamp,
            });
          }
        });
        final snackBar = SnackBar(
          content: Text('${movie.title} added to $addToList'),
          action: SnackBarAction(
              label: 'SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WatchlistScreen(
                      getListFor: addToList,
                    );
                  }),
                );
              }),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('${movie.title} already added to $addToList'),
          action: SnackBarAction(
              label: 'SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WatchlistScreen(
                      getListFor: addToList,
                    );
                  }),
                );
              }),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    });
  }

  static void addSeriesToFirestore(
      Series serie, String addToList, BuildContext context) {
    _firestore
        .collection(addToList)
        .where('id', isEqualTo: serie.id)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      print(snapshot.documents.length);
      if (snapshot.documents.length == 0) {
        _firestore.collection(addToList).add({
          'id': serie.id,
          'type': serie.type,
          'timestamp': Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch),
        });
        _firestore
            .collection('series')
            .where('id', isEqualTo: serie.id)
            .getDocuments()
            .then((QuerySnapshot snapshot) {
          if (snapshot.documents.length == 0) {
            _firestore.collection('series').add({
              'id': serie.id,
              'name': serie.name,
              'poster_path': serie.posterPath,
              'vote_average': serie.voteAverage,
              'overview': serie.overview,
              'type': serie.type,
//              'timestamp': serie.timeStamp,
            });
          }
        });
        final snackBar = SnackBar(
          content: Text('${serie.name} added to $addToList'),
          action: SnackBarAction(
              label: 'SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WatchlistScreen(
                      getListFor: addToList,
                    );
                  }),
                );
              }),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('${serie.name} already added to $addToList'),
          action: SnackBarAction(
              label: 'SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WatchlistScreen(
                      getListFor: addToList,
                    );
                  }),
                );
              }),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    });
  }

  static void deleteAllDocuments() {
    _firestore
        .collection('watchlist')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        element.reference.delete();
      });
    });
    _firestore
        .collection('watched')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        element.reference.delete();
      });
    });
    _firestore
        .collection('movies')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        element.reference.delete();
      });
    });
    _firestore
        .collection('series')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((element) {
        element.reference.delete();
      });
    });
  }

  static Future<List<dynamic>> getWatchlistOrWatched(
      String getList, bool limit) async {
    try {
      List<dynamic> ids = [];
      QuerySnapshot snapshot;
      if (limit) {
        snapshot = await _firestore
            .collection(getList)
            .limit(10)
            .orderBy('timestamp', descending: true)
            .getDocuments();
      } else {
        snapshot = await _firestore
            .collection(getList)
            .orderBy('timestamp', descending: true)
            .getDocuments();
      }
      if (snapshot.documents != null) {
        for (DocumentSnapshot element in snapshot.documents) {
          QuerySnapshot ele = await _firestore
              .collection(element.data['type'])
              .where('id', isEqualTo: element.data['id'])
              .getDocuments();
          if (ele.documents != null) {
            ele.documents.forEach((element) {
              ids.add(element.data);
            });
          }
        }
      }
      return ids;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future deleteShowFromFirestore(
      dynamic object, String getListFor) async {
    try {
      //deleting document related to getListFor
      QuerySnapshot snapshot = await _firestore
          .collection(getListFor)
          .where('id', isEqualTo: object['id'])
          .getDocuments();
      if (snapshot.documents.length > 0) {
        for (DocumentSnapshot element in snapshot.documents) {
          element.reference.delete();
        }
      }

      //checking if present in !getListFor
      snapshot = await _firestore
          .collection(getListFor == 'watchlist' ? 'watched' : 'watchlist')
          .where('id', isEqualTo: object['id'])
          .getDocuments();
      print(
          '${getListFor == 'watchlist' ? 'watched' : 'watchlist'}: ${snapshot.documents.length}');
      if (snapshot.documents.length == 0) {
        QuerySnapshot objects = await _firestore
            .collection(object['type'] == 'movies' ? 'movies' : 'series')
            .where('id', isEqualTo: object['id'])
            .getDocuments();
        if (objects.documents.length > 0) {
          for (DocumentSnapshot ele in objects.documents) {
            ele.reference.delete();
          }
        }
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  static Future removeFromWatchlist(
      dynamic object, BuildContext context) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('watchlist')
          .where('id', isEqualTo: object['id'])
          .getDocuments();
      if (snapshot.documents != null) {
        for (DocumentSnapshot element in snapshot.documents) {
          element.reference.delete();
        }
      }
      snapshot = await _firestore
          .collection('watched')
          .where('id', isEqualTo: object['id'])
          .getDocuments();
      if (snapshot.documents.length > 0) {
        final snackBar = SnackBar(
          content: Text(
              '${object['type'] == 'movies' ? object['title'] : object['name']} already added to watched'),
          action: SnackBarAction(
              label: 'SHOW',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return WatchlistScreen(
                      getListFor: 'watched',
                    );
                  }),
                );
              }),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        object['type'] == 'movies'
            ? FirestoreHelper.addMovieToFirestore(
                Movie.fromJson(object), 'watched', context)
            : FirestoreHelper.addSeriesToFirestore(
                Series.fromJson(object), 'watched', context);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future getCurrentUser() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      print('uid ${user.uid}');
      if (user == null) return;
      return user.uid;
    } catch (e) {
      print(e);
    }
  }
}
