import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 34, 123, 196),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Poznań',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                //TODO add drawer from right side
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'DZISIAJ'),
              Tab(text: 'JUTRO'),
              Tab(text: '15 DNI'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Text('Text1'),
            Text('Text2'),
            Text('Text3'),
          ],
        ),
      ),
    );
  }
}
