import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/components/dialog/error_dialog.dart';
import '../../core/components/image/user_profile_image.dart';
import '../../core/utilities/helpers/helpers.dart';
import '../../models/models.dart';
import '../../repositories/repositories.dart';

import 'package:flutter_sample/screens/edit_profile/cubit/editprofile_cubit.dart';
import 'package:flutter_sample/screens/profile/bloc/profile_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileScreenArgs {
  final BuildContext context;

  const EditProfileScreenArgs({@required this.context});
}

class EditProfileScreen extends StatelessWidget {
  static const String routeName = '/editProfile';

  EditProfileScreen({
    Key key,
    @required this.user,
  }) : super(key: key);

  static Route route({@required EditProfileScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditprofileCubit>(
        create: (_) => EditprofileCubit(
            userRepository: context.read<UserRepository>(),
            storageRepository: context.read<StorageRepository>(),
            profileBloc: args.context.read<ProfileBloc>()),
        child: EditProfileScreen(
          user: args.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
        ),
        body: BlocConsumer<EditprofileCubit, EditprofileState>(
          listener: (context, state) {
            if (state.status == EditProfileStatus.success) {
              Navigator.of(context).pop();
            } else if (state.status == EditProfileStatus.error) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorDialog(content: state.failure.message));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state.status == EditProfileStatus.submitting)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 32.0,
                  ),
                  GestureDetector(
                    onTap: () => _selectedProfileImage(context),
                    child: UserProfileImage(
                      radius: 80.0,
                      profileImageUrl: user.profileImageUrl,
                      profileImage: state.profileImage,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: user.username,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              prefixIcon: Icon(
                                Icons.supervised_user_circle_outlined,
                                color: Colors.black54,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 14, right: 15),
                            ),
                            onChanged: (value) => context
                                .read<EditprofileCubit>()
                                .usernameImageChanged(value),
                            validator: (value) => value.trim().isEmpty
                                ? 'Username not be empty!'
                                : null,
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            initialValue: user.bio,
                            decoration: InputDecoration(
                              hintText: 'Bio',
                              prefixIcon: Icon(
                                Icons.book,
                                color: Colors.black54,
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 14, right: 15),
                            ),
                            onChanged: (value) => context
                                .read<EditprofileCubit>()
                                .bioImageChanged(value),
                            validator: (value) => value.trim().isEmpty
                                ? 'bio not be empty!'
                                : null,
                          ),
                          const SizedBox(height: 28.0),
                          ElevatedButton(
                            onPressed: () => _submitForm(context,
                                state.status == EditProfileStatus.submitting),
                            child: Text('Update Profile'),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _selectedProfileImage(BuildContext context) async {
    // final pickedFile =await ImagePicker().getImage(source: ImageSource.gallery);  //standart image picker code if you do not want to user external ImagePicker package on this app.
    final pickedFile = await ImageHelper.pickImageFromGallery(
      context: context,
      cropStyle: CropStyle.circle,
      title: 'Profile Image',
    );
    if (pickedFile != null) {
      context.read<EditprofileCubit>().profileImageChanged(pickedFile);
    }
  }

  _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<EditprofileCubit>().submit();
    }
  }
}
