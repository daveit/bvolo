dateToDateString = (date) ->
  m = (date.getMonth() + 1)
  m = "0" + m  if m < 10
  d = date.getDate()
  d = "0" + d  if d < 10
  date.getFullYear() + "-" + m + "-" + d

docProperty = (_id,collection,name)->
	if Meteor.isClient
		window[collection].findOne(_id:_id).name
	else if Meteor.isServer
		global[collection].findOne(_id:_id).name

if Meteor.isClient
	window.dateToDateString = dateToDateString
else if Meteor.isServer
	global.dateToDateString = dateToDateString

if Meteor.isClient
	window.docProperty = docProperty
else if Meteor.isServer
	global.docProperty = docProperty