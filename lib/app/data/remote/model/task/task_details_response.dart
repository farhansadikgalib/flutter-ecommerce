import 'dart:convert';

TaskDetailsResponse taskDetailsResponseFromJson(String str) => TaskDetailsResponse.fromJson(json.decode(str));

String taskDetailsResponseToJson(TaskDetailsResponse data) => json.encode(data.toJson());

class TaskDetailsResponse {
  TaskDetails? taskDetails;
  String? message;
  int? status;

  TaskDetailsResponse({
    this.taskDetails,
    this.message,
    this.status,
  });

  factory TaskDetailsResponse.fromJson(Map<String, dynamic> json) => TaskDetailsResponse(
    taskDetails: json["TaskDetails"] == null ? null : TaskDetails.fromJson(json["TaskDetails"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "TaskDetails": taskDetails?.toJson(),
    "message": message,
    "status": status,
  };
}

class TaskDetails {
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

  TaskDetails({
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

  factory TaskDetails.fromJson(Map<String, dynamic> json) => TaskDetails(
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
