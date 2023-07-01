


class Details {
  String _name, _id;
  Details(
    this._name,
    this._id,
  );

 factory Details.fromJSON(Map<String, dynamic>? json) {
    if (json != null) {
      return Details(json['name'], json['id']);
    } else {
      return Details('', '');
    }
  }

 String get name => this._name;
  String get id => this._id;
}




