import 'dart:convert';
import 'package:my_collection/utils/date_utils.dart';

GoogleBooksApiResponseModel googleBookApiResponseModelFromJson(String str) => GoogleBooksApiResponseModel.fromJson(json.decode(str));

String googleBookApiResponseModelToJson(GoogleBooksApiResponseModel data) => json.encode(data.toJson());

class GoogleBooksApiResponseModel {
  String? uuid;
  String kind;
  int totalItems;
  List<BookListItem> items;

  GoogleBooksApiResponseModel({
    required this.kind,
    required this.totalItems,
    required this.items,
    this.uuid
  });

  factory GoogleBooksApiResponseModel.fromJson(Map<String, dynamic> json) => GoogleBooksApiResponseModel(
    kind: json["kind"],
    totalItems: json["totalItems"],
    uuid: json["uuid"] ?? "",
    items: List<BookListItem>.from(json["items"].map((x) => BookListItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "totalItems": totalItems,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  GoogleBooksApiResponseModel copyWith(
      {String? kind, String? uuid, List<BookListItem>? items}) {
    return GoogleBooksApiResponseModel(
        kind: kind ?? this.kind,
        items: items ?? this.items,
        totalItems: items?.length ?? this?.items.length ?? 0,
        uuid: uuid ?? this.uuid
    );
  }
}

class BookListItem {
  String kind;
  String id;
  String? etag;
  String selfLink;
  VolumeInfo volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;
  SearchInfo? searchInfo;

  BookListItem({
    required this.kind,
    required this.id,
    this.etag,
    required this.selfLink,
    required this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

  factory BookListItem.fromJson(Map<String, dynamic> json) => BookListItem(
    kind: json["kind"],
    id: json["id"],
    selfLink: json["selfLink"],
    volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "id": id,
    "selfLink": selfLink,
    "volumeInfo": volumeInfo.toJson()
  };
}

class AccessInfo {
  String country;
  String viewability;
  bool embeddable;
  bool publicDomain;
  String textToSpeechPermission;
  Epub epub;
  Epub pdf;
  String webReaderLink;
  String accessViewStatus;
  bool quoteSharingAllowed;

  AccessInfo({
    required this.country,
    required this.viewability,
    required this.embeddable,
    required this.publicDomain,
    required this.textToSpeechPermission,
    required this.epub,
    required this.pdf,
    required this.webReaderLink,
    required this.accessViewStatus,
    required this.quoteSharingAllowed,
  });

  factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
    country: json["country"],
    viewability: json["viewability"],
    embeddable: json["embeddable"],
    publicDomain: json["publicDomain"],
    textToSpeechPermission: json["textToSpeechPermission"],
    epub: Epub.fromJson(json["epub"]),
    pdf: Epub.fromJson(json["pdf"]),
    webReaderLink: json["webReaderLink"],
    accessViewStatus: json["accessViewStatus"],
    quoteSharingAllowed: json["quoteSharingAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "viewability": viewability,
    "embeddable": embeddable,
    "publicDomain": publicDomain,
    "textToSpeechPermission": textToSpeechPermission,
    "epub": epub.toJson(),
    "pdf": pdf.toJson(),
    "webReaderLink": webReaderLink,
    "accessViewStatus": accessViewStatus,
    "quoteSharingAllowed": quoteSharingAllowed,
  };
}

class Epub {
  bool isAvailable;

  Epub({
    required this.isAvailable,
  });

  factory Epub.fromJson(Map<String, dynamic> json) => Epub(
    isAvailable: json["isAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "isAvailable": isAvailable,
  };
}

class SaleInfo {
  String country;
  String saleability;
  bool isEbook;

  SaleInfo({
    required this.country,
    required this.saleability,
    required this.isEbook,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
    country: json["country"],
    saleability: json["saleability"],
    isEbook: json["isEbook"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "saleability": saleability,
    "isEbook": isEbook,
  };
}

class SearchInfo {
  String textSnippet;

  SearchInfo({
    required this.textSnippet,
  });

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
    textSnippet: json["textSnippet"],
  );

  Map<String, dynamic> toJson() => {
    "textSnippet": textSnippet,
  };
}

class VolumeInfo {
  String title;
  String? subtitle;
  List<String>? authors;
  List<String>? categories;
  DateTime? publishedDate;
  String? description;
  ReadingModes readingModes;
  int? pageCount;
  String printType;
  String maturityRating;
  bool allowAnonLogging;
  String contentVersion;
  ImageLinks? imageLinks;
  String language;
  String previewLink;
  String infoLink;
  String canonicalVolumeLink;
  dynamic averageRating;
  int? ratingsCount;
  PanelizationSummary? panelizationSummary;

  VolumeInfo({
    required this.title,
    this.subtitle,
    this.authors,
    this.categories,
    required this.publishedDate,
    this.description,
    required this.readingModes,
    this.pageCount,
    required this.printType,
    required this.maturityRating,
    required this.allowAnonLogging,
    required this.contentVersion,
    required this.imageLinks,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
    this.averageRating,
    this.ratingsCount,
    this.panelizationSummary,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
    title: json["title"],
    subtitle: json["subtitle"],
    authors: json["authors"] == null ? [] : List<String>.from(json["authors"]!.map((x) => x)),
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    publishedDate: (json["publishedDate"] == null || json["publishedDate"].length<10) ? null : DateUtils.getDateTime(json["publishedDate"]),
    description: json["description"],
    readingModes: ReadingModes.fromJson(json["readingModes"]),
    pageCount: json["pageCount"],
    printType: json["printType"],
    maturityRating: json["maturityRating"],
    allowAnonLogging: json["allowAnonLogging"] ?? false,
    contentVersion: json["contentVersion"] ?? "",
    imageLinks: json["imageLinks"] == null ? null : ImageLinks.fromJson(json["imageLinks"]),
    language: json["language"]  ?? "",
    previewLink: json["previewLink"] ?? "",
    infoLink: json["infoLink"] ?? "",
    canonicalVolumeLink: json["canonicalVolumeLink"] ?? "",
    averageRating: json["averageRating"] ?? 0.0,
    ratingsCount: json["ratingsCount"] ?? 0,
    panelizationSummary: json["panelizationSummary"] == null ? null : PanelizationSummary.fromJson(json["panelizationSummary"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "publishedDate": DateUtils.formatDateTime(publishedDate),
    "description": description,
    "readingModes": readingModes.toJson(),
    "pageCount": pageCount,
    "printType": printType,
    "maturityRating": maturityRating,
    "imageLinks": imageLinks?.toJson(),
    "language": language,
    "previewLink": previewLink,
    "infoLink": infoLink,
    "canonicalVolumeLink": canonicalVolumeLink,
    "averageRating": averageRating,
    "ratingsCount": ratingsCount,
  };
}

class ImageLinks {
  String smallThumbnail;
  String thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
    smallThumbnail: json["smallThumbnail"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "smallThumbnail": smallThumbnail,
    "thumbnail": thumbnail,
  };
}

class PanelizationSummary {
  bool containsEpubBubbles;
  bool containsImageBubbles;

  PanelizationSummary({
    required this.containsEpubBubbles,
    required this.containsImageBubbles,
  });

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) => PanelizationSummary(
    containsEpubBubbles: json["containsEpubBubbles"],
    containsImageBubbles: json["containsImageBubbles"],
  );

  Map<String, dynamic> toJson() => {
    "containsEpubBubbles": containsEpubBubbles,
    "containsImageBubbles": containsImageBubbles,
  };
}

class ReadingModes {
  bool text;
  bool image;

  ReadingModes({
    required this.text,
    required this.image,
  });

  factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
    text: json["text"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "image": image,
  };
}