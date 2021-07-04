enum TaskStatus{
ACTIVE,
COMPLETED
}

extension TaskStatusExt on TaskStatus{
  String get type{
    switch(this){
      case TaskStatus.ACTIVE:{
        return 'A';
      }
      case TaskStatus.COMPLETED:{
        return 'C';
      }
      default:{
        return 'A';
      }
    }
  }
}