import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/repositories/repositories.dart';

import 'package:flutter_sample/screens/edit_profile/cubit/editprofile_cubit.dart';
import 'package:flutter_sample/screens/profile/bloc/profile_bloc.dart';

class EditProfileScreenArgs {
  final BuildContext context;

  const EditProfileScreenArgs({@required this.context});
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/editProfile';

  static Route route({@required EditProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditprofileCubit>(
        child: EditProfileScreen(),
        create: (_) => EditprofileCubit(
            userRepository: context.read<UserRepository>(),
            storageRepository: context.read<StorageRepository>(),
            profileBloc: args.context.read<ProfileBloc>()),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
      ),
    );
  }
}
