part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, submitting, success, error }

class CreatePostState extends Equatable {
  final File? postImage;
  final String caption;
  final CreatePostStatus status;
  final Failure failure;

  CreatePostState({
    required this.postImage,
    required this.caption,
    required this.status,
    required this.failure,
  });

  factory CreatePostState.initial() {
    return CreatePostState(
      postImage: null,
      caption: '',
      status: CreatePostStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [postImage, caption, status, failure];

  CreatePostState copyWith({
    File? postImage,
    String? caption,
    CreatePostStatus? status,
    Failure? failure,
  }) {
    return CreatePostState(
      postImage: postImage ?? this.postImage,
      caption: caption ?? this.caption,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
