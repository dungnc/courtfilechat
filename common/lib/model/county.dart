class County{
  String name;

  static County fromMap(Map<String, dynamic> data){
    County county = new County();
    county.name = data['name'];
    return county;
  }

  static Map<String, dynamic> toMap(County county) {
    return {
      'name' : county.name,
    };
  }
}