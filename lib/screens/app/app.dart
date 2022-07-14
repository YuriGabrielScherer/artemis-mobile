import 'package:artemis_mobile/core/enums/enum_auth_status.dart';
import 'package:artemis_mobile/core/getit.dart';
import '../../core/auth/bloc/auth_bloc.dart';
import '../../core/theme_provider.dart';
import '../../providers/repositories/impl/auth_repository_impl.dart';
import '../../providers/repositories/impl/person_repository_impl.dart';
import '../graduation/list/graduation_list.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';
import '../profile/profile_page.dart';
import '../../splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        personRepository: getIt<PersonRepository>(),
        authRepository: getIt<AuthRepository>(),
      ),
      child: const AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Federação Catarinense',
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeProvider.light,
      darkTheme: ThemeProvider.dark,
      onGenerateRoute: (_) => SplashPage.route(),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: ((context, state) {
            switch (state.status) {
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  BasePage.route(),
                  (route) => false,
                );
                break;
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          }),
          child: child,
        );
      },
    );
  }
}

class BasePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BasePage());
  }

  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => BasePageState();
}

class BasePageState extends State<BasePage> {
  final screens = const [
    HomePage(),
    GraduationListPage(),
    ProfilePage(),
  ];

  int currentIndex = 0;

  void changeScreen(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changeScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Graduação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
