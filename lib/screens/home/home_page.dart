import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/bloc/auth_bloc.dart';
import 'widgets/graduation_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Federação Catarinense'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Olá, ${state.person!.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 24),
                GraduationCardWidget(person: state.person!),
              ],
            );
          },
        ),
      ),
    );
  }
}
