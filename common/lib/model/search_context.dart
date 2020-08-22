class SearchContext {
  String context;
  dynamic content;
  String status;

  
  static SearchContext fromMap(Map<String, dynamic> data){
    SearchContext searchContext = new SearchContext();

    searchContext.content = data['content'];
    searchContext.context = data['context'];
    searchContext.status = data['status'];

    return searchContext;
  }

  static Map<String, dynamic> toMap(SearchContext searchContext) {
    return {
      'content' : searchContext.content,
      'context' : searchContext.context,
      'status' : searchContext.status
    };
  }
}