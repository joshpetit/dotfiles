class DataClass {
  final String first;
  final String second;
  final Other third;
  final List<Other> newList;

  DataClass({
    required this.first,
    required this.second,
    required this.third,
  });

  DataClass.fromJson(Map<String, dynamic> json)
      : this(
          first: json('first'),
          second: json('second'),
          third: json('third'),
        );

  DataClass.fromJson(Map<String, dynamic> json)
      : this(
          first: json('first'),
          second: json('second'),
          third: json('third'),
          newList: json('newList'),
        );

  Map<String, dynamic> toJson() => {

  };


  void doThing() {
    print("WHAT");
  }
}
