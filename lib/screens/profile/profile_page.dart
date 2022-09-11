import 'athlete_info/profile_athlete_info.dart';
import 'widgets/info_text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/auth/bloc/auth_bloc.dart';
import '../../core/enums/enum_gender.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: const [_LogoutButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.person == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final person = state.person!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 72,
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Column(
                    children: [
                      Text(
                        person.name,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                      ),
                      if (person.association != null)
                        Text('Associação ${person.association!.name}', style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 8),
                InfoTextWidget(title: 'Código', data: person.code.toString()),
                InfoTextWidget(title: 'Data de Nascimento', data: DateFormat('dd/MM/yyyy').format(person.birth)),
                InfoTextWidget(title: 'Documento', data: person.document),
                InfoTextWidget(title: 'Gênero', data: person.gender.name),
                ProfileAthleteInfo(person: person),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Adicionar confirmação
        context.read<AuthBloc>().add(AuthLogoutRequested());
      },
      icon: const Icon(Icons.logout_rounded),
      splashRadius: 24,
    );
  }
}
