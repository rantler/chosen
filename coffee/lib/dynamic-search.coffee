class DynamicSearch
  
  constructor: (@url_or_function) ->
  
  handler: (query, tokens, response, finalizer, data_stripper, caller) ->
    data = []
    groups_added = 1

    if data_stripper
      tokens = data_stripper tokens

    if _.isHash(tokens)
      data.push DynamicSearch.prototype.emptyToken 0, 0
      groups = _.keys(tokens)
      groups.each (key) ->
        group = tokens[key]
        group_array_index = data.size()
        data.push DynamicSearch.prototype.group_token key, group_array_index, group.size()
        for token in group
          data.push DynamicSearch.prototype.child_token token, data.size(), group_array_index, (data.size() - groups_added)
        groups_added++
    else
      for token in tokens
        data.push DynamicSearch.prototype.child_token token, data.size(), null, data.size()

    finalizer query, data, response, caller

  emptyToken: (array_index, options_index)->
    { array_index: array_index, options_index: options_index, empty: true }

  group_token: (name, index, number_of_children) ->
    console.log("group_token: name = #{name}, index = #{index}, number_of_children = #{number_of_children}") if jQuery.fn.chosen().debug?
    group = {
      array_index: index,
      group: true,
      label: name.titleize(),
      children: number_of_children,
      disabled: false,
    }
    group
   
  child_token: (token, array_index, group_index, options_index) ->
    child = {
      array_index: array_index,
      options_index: options_index,
      group_array_index: if group_index then group_index else null
      value: token.id,
      external_id: token.external_id,
      selected: false,
      disabled: false,
      text: token.name,
      empty: false,
      group: false,
      dom_id: '123',
      html: token.html ? token.description ? token.name
    }
    child

  find: (search, finalizer, data_stripper, caller) ->
    if search.length > 0
      if _.isString @url_or_function
        # jQuery(document).ajaxError (err, jqxhr, settings, exception) ->
          # alert("error: " + err + "\njqxhr: " + jqxhr + "\nsettings.url: " + settings.url + "\nexception: " + exception)
        jQuery.get(@url_or_function, { q: search, parent_id: this.parent_id },
          (tokens, status, response) ->
            success = if (status == 'success') then null else { error_code: response.status }
            DynamicSearch.prototype.handler(search, tokens, success, finalizer, data_stripper, caller)
          ,
        'json');
      else
        handler = (search, tokens, response) ->
          error = null
          if response
            error = if response.status == 'success' then null else { error_code: response.status }
          DynamicSearch.prototype.handler(search, tokens, error, finalizer, data_stripper, caller)
        @url_or_function.call this, search, handler

this.DynamicSearch = DynamicSearch
