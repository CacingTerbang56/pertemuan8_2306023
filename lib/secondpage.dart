import 'package:flutter/material.dart';
import 'models/pict_model.dart';
import 'services/pict_service.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List<PictModel>> futurePictures;

  @override
  void initState() {
    super.initState();
    futurePictures = PictService.getPictures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sopirangkotleleskadungora"),
        backgroundColor: Colors.green,
      ),

      body: FutureBuilder<List<PictModel>>(
        future: futurePictures,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final pictures = snapshot.data!;

            return ListView.builder(
              itemCount: pictures.length,

              itemBuilder: (context, index) {
                final picture = pictures[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 4,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        picture.downloadUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Author: ${picture.author}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.blue,
            child: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.green,
            child: Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
