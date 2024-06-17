import 'dart:convert';

CustomResponseModel customResponseModelFromJson(String str) => CustomResponseModel.fromJson(json.decode(str));

class CustomResponseModel {
    List<CustomData>? data;
    Links? links;
    Meta? meta;
    int? status;

    CustomResponseModel({
        this.data,
        this.links,
        this.meta,
        this.status,
    });

    factory CustomResponseModel.fromJson(Map<String, dynamic> json) => CustomResponseModel(
        data: json["data"] == null ? [] : List<CustomData>.from(json["data"]!.map((x) => CustomData.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        status: json["status"],
    );
}

class CustomData {
    String? id;
    String? mobileNumber;
    String? email;
    String? state;
    String? stateName;
    String? name;

    CustomData({
        this.id,
        this.mobileNumber,
        this.email,
        this.state,
        this.stateName,
        this.name,
    });

    factory CustomData.fromJson(Map<String, dynamic> json) => CustomData(
        id: json["id"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        state: json["state"],
        stateName: json["state_name"],
        name: json["name"],
    );
}

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
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
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
