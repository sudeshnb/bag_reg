import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../data/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Object> bagDetection;
  final DataRepository repository = DataRepository();

  Widget? image = const SizedBox();
  String downloadURL = '';

  Future downloadURLExample(String imagePath) async {
    downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();

    return downloadURL;
  }

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('detectedbags').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return ListTile(
                    title: Text(DateFormat.yMEd()
                        .add_jms()
                        .format(DateTime.parse(data['time']))),
                    // subtitle: image ?? const SizedBox(),
                    subtitle: getImages(data['image']),
                  );
                }).toList(),
              );
            } else {
              return const Text('Something went wrong');
            }
          }),
    );
  }

  Widget getImages(String imagePath) {
    return FutureBuilder(
        future: downloadURLExample(imagePath),
        builder: (builder, data) {
          var image = data.data;
          if (data.hasData) {
            return Image.network(
              image.toString(),
              width: 200,
              height: 250,
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
