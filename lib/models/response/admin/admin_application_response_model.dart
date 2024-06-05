import 'dart:convert';

AdminApplicationResponseModel adminApplicationResponseModelFromJson(
        String str) =>
    AdminApplicationResponseModel.fromJson(json.decode(str));

class AdminApplicationResponseModel {
  List<ApplicationResponse>? data;
  Links? links;
  Meta? meta;
  int? status;

  AdminApplicationResponseModel({
    this.data,
    this.links,
    this.meta,
    this.status,
  });

  factory AdminApplicationResponseModel.fromJson(Map<String, dynamic> json) =>
      AdminApplicationResponseModel(
        data: json["data"] == null
            ? []
            : List<ApplicationResponse>.from(
                json["data"]!.map((x) => ApplicationResponse.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"],
      );
}

class ApplicationResponse {
  String? id;
  String? status;
  String? userId;
  String? companyName;
  String? lastMarked;
  MarkedBy? markedBy;
  MarkedTo? markedTo;
  DateTime? firstReceived;
  DateTime? lastReceived;

  ApplicationResponse({
    this.id,
    this.status,
    this.userId,
    this.companyName,
    this.lastMarked,
    this.markedBy,
    this.markedTo,
    this.firstReceived,
    this.lastReceived,
  });

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) =>
      ApplicationResponse(
        id: json["id"],
        status: json["status"],
        userId: json["user_id"],
        companyName: json["company_name"],
        lastMarked: json["last_marked"],
        markedBy: markedByValues.map[json["marked_by"]]!,
        markedTo: markedToValues.map[json["marked_to"]]!,
        firstReceived: json["first_received"] == null
            ? null
            : DateTime.parse(json["first_received"]),
        lastReceived: json["last_received"] == null
            ? null
            : DateTime.parse(json["last_received"]),
      );
}

enum MarkedBy { divisionalHead, memberSecretary, producer }

final markedByValues = EnumValues({
  "Divisional Head": MarkedBy.divisionalHead,
  "Member Secretary": MarkedBy.memberSecretary,
  "Producer": MarkedBy.producer
});

enum MarkedTo { approvingAuthorityMs, backToRetreader, divisionalHead }

final markedToValues = EnumValues({
  "Approving Authority(MS)": MarkedTo.approvingAuthorityMs,
  "Back to Retreader": MarkedTo.backToRetreader,
  "Divisional Head": MarkedTo.divisionalHead
});

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
