import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  bool? isDone;
  bool? isDeleted;

  Task({
    required this.title,
    this.isDone,
    this.isDeleted,
  }) {
    isDone = isDone ?? false; //?? mean null
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    if (isDone != null) {
      result.addAll({'isDone': isDone});
    }
    if (isDeleted != null) {
      result.addAll({'isDeleted': isDeleted});
    }

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        isDone,
        isDeleted,
      ];
}
