Config =
	name: 'Bell-Vista, On-Line-Ordering'
	logo: ->
		'<b>' + @name + '</b>'
	footer: ->
		@name + ' - Copyright 2014'
	emails:
		from: 'noreply@' + Meteor.absoluteUrl()
		notification: 'benjaminpeterjonesesquire@gmail.com'
	recentDays: 30

if Meteor.isClient
	window.Config = Config
else if Meteor.isServer
	global.Config = Config