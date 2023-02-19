class OwnerSignUpModel {
  String name, email, pswd;
  OwnerSignUpModel(this.name, this.email, this.pswd);
}

class OwnerLoginModel {
  String email, pswd;
  OwnerLoginModel(this.email, this.pswd);
}

class StoreModel {
  String name, location, description, type, img, start, end, employees;
  StoreModel(this.name, this.location, this.description, this.type, this.img,
      this.start, this.end, this.employees);
}

class Store {
  String _id, name, location, id, description, type, img, start, end, employees;
  Store(this._id, this.name, this.location, this.id, this.description,
      this.type, this.img, this.start, this.end, this.employees);
}

class ServiceModel {
  String name, description, price, ogprice, img, ownerid, storeid;

  ServiceModel(this.name, this.description, this.price, this.ogprice, this.img,
      this.ownerid, this.storeid);
}

class GetServiceModel {
  String _id, name, description, price, ogprice, img, ownerid, storeid, id;
  GetServiceModel(this._id, this.name, this.description, this.price,
      this.ogprice, this.img, this.ownerid, this.storeid, this.id);
}

class idModel {
  String id;
  idModel(this.id);
}

class GetOrderModel {
  String _id,
      start,
      end,
      storeid,
      serviceid,
      userid,
      price,
      date,
      servicename,
      storename,
      orderid,
      status;
  GetOrderModel(
    this._id,
    this.start,
    this.end,
    this.storeid,
    this.serviceid,
    this.userid,
    this.price,
    this.date,
    this.servicename,
    this.storename,
    this.orderid,
    this.status,
  );
}
