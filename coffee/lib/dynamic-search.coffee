class DynamicSearch
  
  constructor: (@url) ->

  handler: (query, tokens, response, finalizer, caller) ->
    data = []

    for token in tokens
        data.push {
          array_index: tokens.indexOf(token), 
          options_index: tokens.indexOf(token), 
          group_array_index: 0, 
          value: token.id,
          external_id: token.external_id,
          selected: false, 
          disabled: false, 
          text: token.name,
          group: false, 
          dom_id: '123', 
          html: token.name
        }

    finalizer(data, caller)

  find: (search, finalizer, caller) ->
    if search.length > 0
      $j.get(@url, { q: search, parent_id: this.parent_id },
        (tokens, status, response) ->
          DynamicSearch.prototype.handler(search, tokens, (status == 'success' ? null : { error_code: response.status }), finalizer, caller);
        ,
      'json');

this.DynamicSearch = DynamicSearch
