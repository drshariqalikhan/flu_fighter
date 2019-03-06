// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) {
    final jsonData = json.decode(str);
    return News.fromJson(jsonData);
}

String newsToJson(News data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class News {
    String adUnitId;
    String code;
    String country;
    int fluNear;
    List<Fludatum> fludata;
    List<NewsElement> news;

    News({
        this.adUnitId,
        this.code,
        this.country,
        this.fluNear,
        this.fludata,
        this.news,
    });

    factory News.fromJson(Map<String, dynamic> json) => new News(
        adUnitId: json["AdUnitID"],
        code: json["code"],
        country: json["country"],
        fluNear: json["fluNear"],
        fludata: new List<Fludatum>.from(json["fludata"].map((x) => Fludatum.fromJson(x))),
        news: new List<NewsElement>.from(json["news"].map((x) => NewsElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "AdUnitID": adUnitId,
        "code": code,
        "country": country,
        "fluNear": fluNear,
        "fludata": new List<dynamic>.from(fludata.map((x) => x.toJson())),
        "news": new List<dynamic>.from(news.map((x) => x.toJson())),
    };
}

class Fludatum {
    String alert;
    String country;
    String countryName;
    Strain mainStrain;
    Strain otherStrain;
    List<double> trend;

    Fludatum({
        this.alert,
        this.country,
        this.countryName,
        this.mainStrain,
        this.otherStrain,
        this.trend,
    });

    factory Fludatum.fromJson(Map<String, dynamic> json) => new Fludatum(
        alert: json["alert"],
        country: json["country"],
        countryName: json["country_name"],
        mainStrain: Strain.fromJson(json["main_strain"]),
        otherStrain: Strain.fromJson(json["other_strain"]),
        trend: new List<double>.from(json["trend"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "alert": alert,
        "country": country,
        "country_name": countryName,
        "main_strain": mainStrain.toJson(),
        "other_strain": otherStrain.toJson(),
        "trend": new List<dynamic>.from(trend.map((x) => x)),
    };
}

class Strain {
    HospitalizationRate hospitalizationRate;
    KillRate killRate;
    String name;
    RecoveryPd recoveryPd;

    Strain({
        this.hospitalizationRate,
        this.killRate,
        this.name,
        this.recoveryPd,
    });

    factory Strain.fromJson(Map<String, dynamic> json) => new Strain(
        hospitalizationRate: hospitalizationRateValues.map[json["hospitalizationRate"]],
        killRate: killRateValues.map[json["killRate"]],
        name: json["name"],
        recoveryPd: recoveryPdValues.map[json["recovery_pd"]],
    );

    Map<String, dynamic> toJson() => {
        "hospitalizationRate": hospitalizationRateValues.reverse[hospitalizationRate],
        "killRate": killRateValues.reverse[killRate],
        "name": name,
        "recovery_pd": recoveryPdValues.reverse[recoveryPd],
    };
}

enum HospitalizationRate { THE_1_IN_100000, THE_1_IN_1000 }

final hospitalizationRateValues = new EnumValues({
    "1 in 1000": HospitalizationRate.THE_1_IN_1000,
    "1 in 100000": HospitalizationRate.THE_1_IN_100000
});

enum KillRate { THE_1_IN_100000, THE_26_RANGE_1166_PER_100000 }

final killRateValues = new EnumValues({
    "1 in 100000": KillRate.THE_1_IN_100000,
    "26 (range 11-66) per 100,000": KillRate.THE_26_RANGE_1166_PER_100000
});

enum RecoveryPd { THE_5_DAYS, THE_10_DAYS }

final recoveryPdValues = new EnumValues({
    "10 days": RecoveryPd.THE_10_DAYS,
    "5 days": RecoveryPd.THE_5_DAYS
});

class NewsElement {
    String articleDate;
    String articleUrl;
    String descrip;
    String imageurl;
    String source;
    String title;

    NewsElement({
        this.articleDate,
        this.articleUrl,
        this.descrip,
        this.imageurl,
        this.source,
        this.title,
    });

    factory NewsElement.fromJson(Map<String, dynamic> json) => new NewsElement(
        articleDate: json["article_date"],
        articleUrl: json["article_url"],
        descrip: json["descrip"],
        imageurl: json["imageurl"] == null ? null : json["imageurl"],
        source: json["source"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "article_date": articleDate,
        "article_url": articleUrl,
        "descrip": descrip,
        "imageurl": imageurl == null ? null : imageurl,
        "source": source,
        "title": title,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
