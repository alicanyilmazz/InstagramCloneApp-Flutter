import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';
import '../../profile/bloc/profile_bloc.dart';
import 'package:meta/meta.dart';

part 'editprofile_state.dart';

class EditprofileCubit extends Cubit<EditprofileState> {
  final UserRepository _userRepository;
  final StorageRepository _storageRepository;
  final ProfileBloc _profileBloc;

  EditprofileCubit({
    required UserRepository userRepository,
    required StorageRepository storageRepository,
    required ProfileBloc profileBloc,
  })  : _userRepository = userRepository,
        _storageRepository = storageRepository,
        _profileBloc = profileBloc,
        super(EditprofileState.inital()) {
    final user = _profileBloc.state.user;
    emit(state.copyWith(username: user.username, bio: user.bio));
  }

  void profileImageChanged(File image) {
    emit(
      state.copyWith(profileImage: image, status: EditProfileStatus.initial),
    );
  }

  void usernameImageChanged(String username) {
    emit(
      state.copyWith(username: username, status: EditProfileStatus.initial),
    );
  }

  void bioImageChanged(String bio) {
    emit(
      state.copyWith(bio: bio, status: EditProfileStatus.initial),
    );
  }

  void submit() async {
    emit(state.copyWith(status: EditProfileStatus.submitting));
    try {
      final user = _profileBloc.state.user;

      var profileImageUrl = user.profileImageUrl;
      if (state.profileImage != null) {
        profileImageUrl = await _storageRepository.uploadProfileImage(
            url: profileImageUrl, image: state.profileImage!);
      }

      final updatedUser = user.copyWith(
        username: state.username,
        bio: state.bio,
        profileImageUrl: profileImageUrl,
      );
      await _userRepository.updateUser(user: updatedUser);
      _profileBloc.add(ProfileLoadUser(userId: user.id));
      emit(state.copyWith(status: EditProfileStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          failure: const Failure(message: 'We were unable to update.'),
        ),
      );
    }
  }
}
