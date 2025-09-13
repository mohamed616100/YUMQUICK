class OrderResopnse {
  Orders? orders;
  bool? status;

  OrderResopnse({this.orders, this.status});

  OrderResopnse.fromJson(Map<String, dynamic> json) {
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Orders {
  List<Active>? active;
  List<Canceled>? canceled;
  List<Completed>? completed;

  Orders({this.active, this.canceled, this.completed});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['active'] != null) {
      active = <Active>[];
      json['active'].forEach((v) {
        active!.add(new Active.fromJson(v));
      });
    }
    if (json['canceled'] != null) {
      canceled = <Canceled>[];
      json['canceled'].forEach((v) {
        canceled!.add(new Canceled.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Completed>[];
      json['completed'].forEach((v) {
        completed!.add(new Completed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.active != null) {
      data['active'] = this.active!.map((v) => v.toJson()).toList();
    }
    if (this.canceled != null) {
      data['canceled'] = this.canceled!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Active {
  Driver? driver;
  int? id;
  List<Items>? items;
  Null? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  Active(
      {this.driver,
        this.id,
        this.items,
        this.orderChangeDate,
        this.orderDate,
        this.shipping,
        this.status,
        this.subtotal,
        this.tax,
        this.total});

  Active.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}

class Driver {
  double? latitude;
  double? longitude;
  String? name;
  String? phone;

  Driver({this.latitude, this.longitude, this.name, this.phone});

  Driver.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class Items {
  String? description;
  int? id;
  String? imagePath;
  String? name;
  double? price;
  int? quantity;
  double? rating;
  double? totalPrice;

  Items(
      {this.description,
        this.id,
        this.imagePath,
        this.name,
        this.price,
        this.quantity,
        this.rating,
        this.totalPrice});

  Items.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    rating = json['rating'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['rating'] = this.rating;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class Canceled {
  Driver? driver;
  int? id;
  List<Items>? items;
  String? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  Canceled(
      {this.driver,
        this.id,
        this.items,
        this.orderChangeDate,
        this.orderDate,
        this.shipping,
        this.status,
        this.subtotal,
        this.tax,
        this.total});

  Canceled.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}



class Completed {
  Driver? driver;
  int? id;
  List<Items>? items;
  String? orderChangeDate;
  String? orderDate;
  double? shipping;
  int? status;
  double? subtotal;
  double? tax;
  double? total;

  Completed(
      {this.driver,
        this.id,
        this.items,
        this.orderChangeDate,
        this.orderDate,
        this.shipping,
        this.status,
        this.subtotal,
        this.tax,
        this.total});

  Completed.fromJson(Map<String, dynamic> json) {
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    orderChangeDate = json['order_change_date'];
    orderDate = json['order_date'];
    shipping = json['shipping'];
    status = json['status'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['order_change_date'] = this.orderChangeDate;
    data['order_date'] = this.orderDate;
    data['shipping'] = this.shipping;
    data['status'] = this.status;
    data['subtotal'] = this.subtotal;
    data['tax'] = this.tax;
    data['total'] = this.total;
    return data;
  }
}