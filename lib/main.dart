import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inherited Widget Demo',
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

        title: Text('Inherited Widget Demo'),
        centerTitle: true,
      ),

      body: ListView(
        children: <Widget>[
          ScopedModel<MyModelState>(
            model: MyModelState(),
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
   
    return ScopedModelDescendant<MyModelState>(
    rebuildOnChange: true,
      builder: (context, child, model) => Card(
      margin: const EdgeInsets.all(8.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        
        children: <Widget>[
          Text('Counter Widget'),
          Text(
            '${model.counterValue}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          OverflowBar(
            
             
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => model.decrementCounter(),
                      
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () => model.incrementCounter(),
                ),
              ],
            ),
          
          SizedBox(height: 50.0),
        ],
      ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {

   return ScopedModelDescendant<MyModelState>(
    rebuildOnChange: true,
      builder: (context, child, model) => Card(
      margin: const EdgeInsets.all(8.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        
        children: <Widget>[
          Text('Child Widget'),
          Text(
            '${model.counterValue}',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          OverflowBar(
            
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () => model.decrementCounter(),
                      
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () => model.incrementCounter(),
                ),
              ],
            ),
          
          SizedBox(height: 50.0),
        ],
      ),
      ),
    );
       
  }
}

// class MyInheritedWidget extends InheritedWidget {
//   final _MyHomePageState myState;

//   const MyInheritedWidget({
//     required Key key,
//     required Widget child,
//     required this.myState,
//   }) : super(key: key, child: child);

//   @override
//   bool updateShouldNotify(MyInheritedWidget oldWidget) {
//     return myState.counterValue != oldWidget.myState.counterValue;
//   }

//   static MyInheritedWidget? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
//   }
// }

class MyModelState extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
