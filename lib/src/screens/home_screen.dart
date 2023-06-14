import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:jsonplaceholder/src/bloc/blocs.dart';
import 'package:jsonplaceholder/src/screens/screens.dart';
import 'package:jsonplaceholder/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiBloc _apiBloc;
  late ServicesBloc _servicesBloc;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

@override
  void didChangeDependencies() {
  _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  
    super.didChangeDependencies();
  }

 Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    _apiBloc.add(OnIsConnected());
  } 


  @override
  void initState() {
    super.initState();
    _apiBloc = BlocProvider.of<ApiBloc>(context);
    _servicesBloc = BlocProvider.of<ServicesBloc>(context);

    _apiBloc.add(OnIsConnected());
    _servicesBloc.add(GetUsers(_apiBloc.state.isConnected));
    _servicesBloc.add(GetPosts(_apiBloc.state.isConnected));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: BlocListener<ApiBloc, ApiState>(
              listener: (context, stateApi) {
                if (!stateApi.isConnected) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Notifications.showSnackBar(
                        'There is no internet connection');
                  });
                }
              },
              child: const _Pages(),
            ),
          
        
        bottomNavigationBar: const _Navigation(),
      
    ));
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        onTap: (value) {
          navigationModel.actualPage = value;
        },
        currentIndex: navigationModel.actualPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Post')
        ]);
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [UsersScreen(), PostsScreen()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  final PageController _pageController = PageController();

  int get actualPage => _actualPage;
  set actualPage(int value) {
    _actualPage = value;
    //curves es la animacion
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController {
    return _pageController;
  }
}
