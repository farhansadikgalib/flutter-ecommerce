import 'dart:convert';

TaskInsertDataResponse taskInsertDataResponseFromJson(String str) => TaskInsertDataResponse.fromJson(json.decode(str));

String taskInsertDataResponseToJson(TaskInsertDataResponse data) => json.encode(data.toJson());

class TaskInsertDataResponse {
  Values? values;
  int? status;
  String? message;

  TaskInsertDataResponse({
    this.values,
    this.status,
    this.message,
  });

  factory TaskInsertDataResponse.fromJson(Map<String, dynamic> json) => TaskInsertDataResponse(
    values: json["values"] == null ? null : Values.fromJson(json["values"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "values": values?.toJson(),
    "status": status,
    "message": message,
  };
}

class Values {
  List<AssignTask>? assignTask;
  List<Plant>? plant;
  List<MaintenanceType>? maintenanceType;
  List<MachineName>? machineName;
  List<Officer>? supervisor;
  List<Officer>? operator;
  List<Officer>? manager;

  Values({
    this.assignTask,
    this.plant,
    this.maintenanceType,
    this.machineName,
    this.supervisor,
    this.operator,
    this.manager,
  });

  factory Values.fromJson(Map<String, dynamic> json) => Values(
    assignTask: json["AssignTask"] == null ? [] : List<AssignTask>.from(json["AssignTask"]!.map((x) => AssignTask.fromJson(x))),
    plant: json["Plant"] == null ? [] : List<Plant>.from(json["Plant"]!.map((x) => Plant.fromJson(x))),
    maintenanceType: json["MaintenanceType"] == null ? [] : List<MaintenanceType>.from(json["MaintenanceType"]!.map((x) => MaintenanceType.fromJson(x))),
    machineName: json["MachineName"] == null ? [] : List<MachineName>.from(json["MachineName"]!.map((x) => MachineName.fromJson(x))),
    supervisor: json["Supervisor"] == null ? [] : List<Officer>.from(json["Supervisor"]!.map((x) => Officer.fromJson(x))),
    operator: json["Operator"] == null ? [] : List<Officer>.from(json["Operator"]!.map((x) => Officer.fromJson(x))),
    manager: json["Manager"] == null ? [] : List<Officer>.from(json["Manager"]!.map((x) => Officer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "AssignTask": assignTask == null ? [] : List<dynamic>.from(assignTask!.map((x) => x.toJson())),
    "Plant": plant == null ? [] : List<dynamic>.from(plant!.map((x) => x.toJson())),
    "MaintenanceType": maintenanceType == null ? [] : List<dynamic>.from(maintenanceType!.map((x) => x.toJson())),
    "MachineName": machineName == null ? [] : List<dynamic>.from(machineName!.map((x) => x.toJson())),
    "Supervisor": supervisor == null ? [] : List<dynamic>.from(supervisor!.map((x) => x.toJson())),
    "Operator": operator == null ? [] : List<dynamic>.from(operator!.map((x) => x.toJson())),
    "Manager": manager == null ? [] : List<dynamic>.from(manager!.map((x) => x.toJson())),
  };
}

class AssignTask {
  int? id;
  String? assignTask;
  String? active;

  AssignTask({
    this.id,
    this.assignTask,
    this.active,
  });

  factory AssignTask.fromJson(Map<String, dynamic> json) => AssignTask(
    id: json["ID"],
    assignTask: json["AssignTask"],
    active: json["Active"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "AssignTask": assignTask,
    "Active": active,
  };
}

class MachineName {
  int? id;
  String? machineName;
  String? active;
  List<Machine>? machines;

  MachineName({
    this.id,
    this.machineName,
    this.active,
    this.machines,
  });

  factory MachineName.fromJson(Map<String, dynamic> json) => MachineName(
    id: json["ID"],
    machineName: json["MachineName"],
    active: json["Active"],
    machines: json["machines"] == null ? [] : List<Machine>.from(json["machines"]!.map((x) => Machine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MachineName": machineName,
    "Active": active,
    "machines": machines == null ? [] : List<dynamic>.from(machines!.map((x) => x.toJson())),
  };
}

class Machine {
  String? id;
  String? machineNameId;
  String? machineId;

  Machine({
    this.id,
    this.machineNameId,
    this.machineId,
  });

  factory Machine.fromJson(Map<String, dynamic> json) => Machine(
    id: json["ID"],
    machineNameId: json["MachineNameID"],
    machineId: json["MachineID"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MachineNameID": machineNameId,
    "MachineID": machineId,
  };
}

class MaintenanceType {
  int? id;
  String? maintenanceType;
  String? active;

  MaintenanceType({
    this.id,
    this.maintenanceType,
    this.active,
  });

  factory MaintenanceType.fromJson(Map<String, dynamic> json) => MaintenanceType(
    id: json["ID"],
    maintenanceType: json["MaintenanceType"],
    active: json["Active"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "MaintenanceType": maintenanceType,
    "Active": active,
  };
}

class Officer {
  int? id;
  String? staffID;
  String? name;
  String? email;
  String? role;
  String? designation;

  Officer({
    this.id,
    this.staffID,
    this.name,
    this.email,
    this.role,
    this.designation,
  });

  factory Officer.fromJson(Map<String, dynamic> json) => Officer(
    id: json["id"],
    staffID: json["staffid"],
    name: json["name"],
    email: json["email"],
    role: json["role"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "staffid": staffID,
    "name": name,
    "email": email,
    "role": role,
    "designation": designation,
  };
}

class Plant {
  int? id;
  String? plantName;
  String? active;

  Plant({
    this.id,
    this.plantName,
    this.active,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
    id: json["ID"],
    plantName: json["PlantName"],
    active: json["Active"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "PlantName": plantName,
    "Active": active,
  };
}
