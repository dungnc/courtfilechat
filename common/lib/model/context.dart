class Context{
  String contextDocId;
  String name;
  String county;

  static Context fromMap(Map<String, dynamic> data){
    Context context = new Context();
    context.contextDocId = data['contextDocId'];
    context.name = data['name'];
    context.county = data['county'];

    return context;
  }
  
  static Map<String, dynamic> toMap(Context context) {
    return {
      'contextDocId' : context.contextDocId,
      'name' : context.name,
      'county' : context.county
    };
  }
}