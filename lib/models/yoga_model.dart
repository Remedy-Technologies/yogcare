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
      longdesc: "1. Sit on the floor or on a mat with legs stretched out in front of you while keeping the spine erect.\n\n2.Bend the right knee and place it on the left thigh. Make sure that the sole of the feet point upward and the heel is close to the abdomen.\n\n3. Now, repeat the same step with the other leg.\n\n4. With both the legs crossed and feet placed on opposite thighs, place your hands on the knees in mudra position.\n\n5. Keep the head straight and spine erect.\n\n 6. Hold and continue with gentle long breaths in and out.",
      img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc"
  )
];
}
