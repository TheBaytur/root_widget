import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InheritedWidget Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(title: 'InheritedWidget Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('InheritedWidget Demo'),
        centerTitle: true,
      ),

      body: ListView(
        children: <Widget>[
          MyInheritedWidget(
            key: UniqueKey(),
            myState: this,
            child: AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      
      elevation: 4.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Root Widget', style: Theme.of(context).textTheme.displaySmall),
          Text(
            '${rootWidgetState?.counterValue}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed:
                    rootWidgetState == null
                        ? null
                        : () => rootWidgetState._incrementCounter(),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed:
                    rootWidgetState == null
                        ? null
                        : () => rootWidgetState._decrementCounter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final rootWidgetState = MyInheritedWidget.of(context)?.myState;
    return Card(
      margin: const EdgeInsets.all(8.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter Widget'),
          Text(
            '${rootWidgetState?.counterValue}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(
            child: OverflowBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed:
                      rootWidgetState == null
                          ? null
                          : () => rootWidgetState._incrementCounter(),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed:
                      rootWidgetState == null
                          ? null
                          : () => rootWidgetState._decrementCounter(),
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final _MyHomePageState myState;

  const MyInheritedWidget({
    required Key key,
    required Widget child,
    required this.myState,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return myState.counterValue != oldWidget.myState.counterValue;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
