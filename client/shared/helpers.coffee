UI.registerHelper 'Config', ->
	Config

UI.registerHelper 'niceName',->
	if Meteor.user().profile.companyName
		Meteor.user().profile.companyName
	else
		Meteor.user().emails[0].address

UI.registerHelper 'Users', ->
	Meteor.users

UI.registerHelper 'User', ->
	Meteor.user()

UI.registerHelper 'categoryCount', (_id) ->
	Items.find(category:_id).fetch().length

UI.registerHelper 'docProperty', (_id,collection,name)->
	docProperty _id, collection, name

UI.registerHelper 'tomorrow', ->
  dateToDateString new Date(new Date().getTime() + 24 * 60 * 60 * 1000);

UI.registerHelper 'prettyDate', (date)->
	unless !date
		dateToDateString(date)