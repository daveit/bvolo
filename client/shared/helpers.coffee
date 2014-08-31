UI.registerHelper 'Config', ->
	Config

UI.registerHelper 'niceName',->
	if Meteor.user().profile.firstName
		Meteor.user().profile.firstName
	else
		Meteor.user().emails[0].address

UI.registerHelper 'Users', ->
	Meteor.users

UI.registerHelper 'User', ->
	Meteor.user()

UI.registerHelper 'categoryCount', (_id) ->
	Items.find(category:_id).fetch().length

UI.registerHelper 'docProperty', (_id,collection,name)->
	window[collection].findOne(_id:_id).name


UI.registerHelper 'tomorrow', ->
  dateToDateString new Date(new Date().getTime() + 24 * 60 * 60 * 1000);

dateToDateString = (date) ->
  m = (date.getMonth() + 1)
  m = "0" + m  if m < 10
  d = date.getDate()
  d = "0" + d  if d < 10
  date.getFullYear() + "-" + m + "-" + d
