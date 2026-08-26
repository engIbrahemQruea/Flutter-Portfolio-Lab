enum ApplicationStatus {
  newApp(1),
  cancelled(2),
  completed(3);

  final int value;
  const ApplicationStatus(this.value);

  factory ApplicationStatus.fromValue(int value) {
    return switch (value) {
      1 => ApplicationStatus.newApp,
      2 => ApplicationStatus.cancelled,
      3 => ApplicationStatus.completed,
      _ => ApplicationStatus.newApp, 
    };
  }
}

