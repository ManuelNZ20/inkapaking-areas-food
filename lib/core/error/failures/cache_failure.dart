import 'failure.dart';

class CacheFailure extends Failure {
  final String message;

  CacheFailure([this.message = 'Error caching data']) : super([message]);

  @override
  List<Object?> get props => [message];
}
