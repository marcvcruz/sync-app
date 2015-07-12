class EventService
  constructor: ($http) ->
    @http = $http

  getEvents: (year, month) ->
    @http.get "/calendar/#{year}/#{month}.json",
      headers: 'Accept': 'application/json'

  getEvent: (id) ->
    @http.get "/events/#{id}/edit.json",
      headers: 'Accept': 'application/json'

  saveEvent: (event, onSuccess, onError) ->
    [action, url]  = if event.id? then ['PATCH', "/events/#{event.id}"] else ['POST', '/events']
    @http
      headers: 'Accept':'application/json'
      method: action
      url: url
      data: { eventForm: event }

angular.module('SyncApp').service 'eventService', ['$http', ($http) -> new EventService($http)]