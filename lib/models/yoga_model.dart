class Yogas{
   final int id;
   final String name;
   final String desc;
   final String longdesc;
   final String img;
   final String music;

  Yogas({required this.id, required this.name, required this.desc,  required this.longdesc, required this.img, required this.music});                        //constructors

  factory Yogas.fromMap(Map<String,dynamic> map){                                //decode
    return Yogas(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        longdesc: map["longdesc"],
        img: map["image"],
        music: map["music"]
    );
    
  }

  toMap() => {                                                                  //encode
    "id" : id,
    "name" : name,
    "desc" : desc,
    "longdesc" : longdesc,
    "img" : img,
    "music" : music
  };
}

class YogaModels{
  static List<Yogas> items = [
  Yogas( 
      id: 100, 
      name: "",
      desc: "",
      longdesc: "",
      img: "",
      music: ""
  )
];
}
