import 'package:flutter/material.dart'; 
import 'package:pertemuan8_2306023/provider/post_provider.dart'; 
import 'package:provider/provider.dart'; 
import 'models/post_model.dart'; 
import 'services/post_service.dart'; 
import 'provider/pict_provider.dart';
import 'secondpage.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        
        ChangeNotifierProvider(
          create: (_) => PostProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => PictProvider(),
        ),

      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Post App",
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "biskuitgosongjogjasleman",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),

      body: const PostPage(),

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          FloatingActionButton(
            heroTag: "btn1",
            backgroundColor: Colors.blue,
            child: const Icon(Icons.home),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),

          const SizedBox(height: 10),

          FloatingActionButton(
            heroTag: "btn2",
            backgroundColor: Colors.green,
            child: const Icon(Icons.image),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PostProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<PostProvider>();

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.posts.isEmpty) {
      return const Center(
        child: Text("Tidak ada data"),
      );
    }

    return ListView.builder(
      itemCount: provider.posts.length,
      itemBuilder: (context, index) {

        final post = provider.posts[index];

        return Card(
          margin: const EdgeInsets.all(10),
          elevation: 4,

          child: Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(post.body),

              ],
            ),
          ),
        );
      },
    );
  }
}