class Yogas{
   final int id;
   final String name;
   final String desc;
   final String longdesc;
   final String img;

  Yogas({required this.id, required this.name, required this.desc,  required this.longdesc, required this.img});                        //constructors

  factory Yogas.fromMap(Map<String,dynamic> map){                                //decode
    return Yogas(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        longdesc: map["longdesc"],
        img: map["image"]
    );
    
  }

  toMap() => {                                                                  //encode
    "id" : id,
    "name" : name,
    "desc" : desc,
    "longdesc" : longdesc,
    "img" : img,
  };
}

class YogaModels{
  static List<Yogas> items = [
  Yogas( 
      id: 100, 
      name: "Priyanshu",
      desc: "ttt",
      longdesc: "ttttttttttttttttttt",
      img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc"
  )
];
}
