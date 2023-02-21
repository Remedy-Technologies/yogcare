class Item{
   final int id;
   final String name;
   final String desc;
   final num price;
   final String color;
   final String img;

  Item({required this.id, required this.name, required this.desc, required this.price, required this.color, required this.img});                        //constructors

  factory Item.fromMap(Map<String,dynamic> map){                                //decode
    return Item(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        price: map["price"],
        color: map["color"],
        img: map["image"]
    );
    
  }

  toMap() => {                                                                  //encode
    "id" : id,
    "name" : name,
    "desc" : desc,
    "price" : price,
    "color" : color,
    "img" : img,
  };
}

class CatalogModels{
  static List<Item> items = [
  Item( 
      id: 1, 
      name: "Priyanshu",
      desc: "ttt",
      price: 888,
      color: "Lorem Ipsum",
      img: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc"
  )
];
}
