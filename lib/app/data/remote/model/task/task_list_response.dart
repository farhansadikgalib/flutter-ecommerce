import 'dart:convert';

TaskListResponse taskListResponseFromJson(String str) => TaskListResponse.fromJson(json.decode(str));

String taskListResponseToJson(TaskListResponse data) => json.encode(data.toJson());

class TaskListResponse {
  List<TaskMaster>? taskMaster;
  String? message;
  int? status;

  TaskListResponse({
    this.taskMaster,
    this.message,
    this.status,
  });

  factory TaskListResponse.fromJson(Map<String, dynamic> json) => TaskListResponse(
    taskMaster: json["TaskMaster"] == null ? [] : List<TaskMaster>.from(json["TaskMaster"]!.map((x) => TaskMaster.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "TaskMaster": taskMaster == null ? [] : List<dynamic>.from(taskMaster!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class TaskMaster {
  String? taskId;
  String? statusId;
  String? presentDeskOperator;
  String? presentDeskSupervisor;
  String? presentDeskManager;
  String? assignTaskId;
  String? plantId;
  String? maintenanceTypeId;
  String? machineNameId;
  String? machineId;
  String? description;
  DateTime? taskDateTime;
  DateTime? operatorStatingTime;
  DateTime? operatorEndingTime;
  String? createBy;
  DateTime? createDate;
  String? plantName;
  String? maintenanceType;
  String? machineName;
  String? machine;
  String? operatorName;
  String? supervisorName;
  String? managerName;
  String? createByName;
  String? statusName;
  String? assignTaskName;

  TaskMaster({
    this.taskId,
    this.statusId,
    this.presentDeskOperator,
    this.presentDeskSupervisor,
    this.presentDeskManager,
    this.assignTaskId,
    this.plantId,
    this.maintenanceTypeId,
    this.machineNameId,
    this.machineId,
    this.description,
    this.taskDateTime,
    this.operatorStatingTime,
    this.operatorEndingTime,
    this.createBy,
    this.createDate,
    this.plantName,
    this.maintenanceType,
    this.machineName,
    this.machine,
    this.operatorName,
    this.supervisorName,
    this.managerName,
    this.createByName,
    this.statusName,
    this.assignTaskName,
  });

  factory TaskMaster.fromJson(Map<String, dynamic> json) => TaskMaster(
    taskId: json["TaskID"],
    statusId: json["StatusID"],
    presentDeskOperator: json["PresentDeskOperator"],
    presentDeskSupervisor: json["PresentDeskSupervisor"],
    presentDeskManager: json["PresentDeskManager"],
    assignTaskId: json["AssignTaskID"],
    plantId: json["PlantID"],
    maintenanceTypeId: json["MaintenanceTypeID"],
    machineNameId: json["MachineNameID"],
    machineId: json["MachineID"],
    description: json["Description"],
    taskDateTime: json["TaskDateTime"] == null ? null : DateTime.parse(json["TaskDateTime"]),
    operatorStatingTime: json["OperatorStatingTime"] == null ? null : DateTime.parse(json["OperatorStatingTime"]),
    operatorEndingTime: json["OperatorEndingTime"] == null ? null : DateTime.parse(json["OperatorEndingTime"]),
    createBy: json["CreateBy"],
    createDate: json["CreateDate"] == null ? null : DateTime.parse(json["CreateDate"]),
    plantName: json["PlantName"],
    maintenanceType: json["MaintenanceType"],
    machineName: json["MachineName"],
    machine: json["Machine"],
    operatorName: json["OperatorName"],
    supervisorName: json["SupervisorName"],
    managerName: json["ManagerName"],
    createByName: json["CreateByName"],
    statusName: json["StatusName"],
    assignTaskName: json["AssignTaskName"],
  );

  Map<String, dynamic> toJson() => {
    "TaskID": taskId,
    "StatusID": statusId,
    "PresentDeskOperator": presentDeskOperator,
    "PresentDeskSupervisor": presentDeskSupervisor,
    "PresentDeskManager": presentDeskManager,
    "AssignTaskID": assignTaskId,
    "PlantID": plantId,
    "MaintenanceTypeID": maintenanceTypeId,
    "MachineNameID": machineNameId,
    "MachineID": machineId,
    "Description": description,
    "TaskDateTime": taskDateTime?.toIso8601String(),
    "OperatorStatingTime": operatorStatingTime?.toIso8601String(),
    "OperatorEndingTime": operatorEndingTime?.toIso8601String(),
    "CreateBy": createBy,
    "CreateDate": createDate?.toIso8601String(),
    "PlantName": plantName,
    "MaintenanceType": maintenanceType,
    "MachineName": machineName,
    "Machine": machine,
    "OperatorName": operatorName,
    "SupervisorName": supervisorName,
    "ManagerName": managerName,
    "CreateByName": createByName,
    "StatusName": statusName,
    "AssignTaskName": assignTaskName,
  };
}
