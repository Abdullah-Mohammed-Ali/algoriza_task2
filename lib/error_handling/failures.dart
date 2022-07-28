abstract class Failures {
  final String msg;

  Failures(this.msg);
}

class DatabaseFailure extends Failures {
  DatabaseFailure(super.msg);
}
