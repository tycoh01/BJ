class JournalPage {
  int id;
  String title;
  DateTime createdDate;

  JournalPage({required this.id, required this.title, required this.createdDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}

class WeeklyPlan extends JournalPage {
  List<String> weeklyTasks;

  WeeklyPlan({required int id, required String title, required DateTime createdDate, required this.weeklyTasks})
      : super(id: id, title: title, createdDate: createdDate);
}

class MonthlyPlan extends JournalPage {
  List<String> monthlyGoals;

  MonthlyPlan({required int id, required String title, required DateTime createdDate, required this.monthlyGoals})
      : super(id: id, title: title, createdDate: createdDate);
}

class AnnualPlan extends JournalPage {
  List<String> yearlyGoals;

  AnnualPlan({required int id, required String title, required DateTime createdDate, required this.yearlyGoals})
      : super(id: id, title: title, createdDate: createdDate);
}

