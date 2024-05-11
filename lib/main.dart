import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:level5_multiblocprovider/counter.dart';
import 'package:level5_multiblocprovider/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData dark = ThemeData.dark();
  final ThemeData light = ThemeData.light();

  @override
  /* without multi bloc provider
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, bool>(
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state ? dark : light,
            home: HomePage(),
          ),
        ),
      ),
    );
  }
  */
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => CounterBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: state ? dark : light,
          home: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Apps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) => Text(
                "Angka saat ini : $state",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => context.read<CounterBloc>().decrement(),
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () => context.read<CounterBloc>().increment(),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ThemeBloc>().changeTheme(),
        child: Icon(Icons.color_lens),
      ),
    );
  }
}
