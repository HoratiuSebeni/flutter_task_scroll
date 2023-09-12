import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_scroll/bloc/data_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable list',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BlocProvider(
        create: (context) => DataBloc()..add(DataEvent.fetch),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<DataBloc>().add(DataEvent.fetch);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrollable list'),
      ),
      body: BlocBuilder<DataBloc, List<dynamic>>(
        builder: (context, data) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['pictureUrl']),
                ),
                title: Text(item['username']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User ID: ${item['userId']}'),
                    Text('Number: ${item['number']}'),
                    Text('Date of Birth: ${item['dateOfBirth']}'),
                    Text('Municipality: ${item['municipality']}'),
                    Text('Province: ${item['province']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
