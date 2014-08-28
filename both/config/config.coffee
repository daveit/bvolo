Config =
	name: 'My App'
	logo: ->
		'<b>' + @name + '</b>'
	footer: ->
		@name + ' - Copyright 2014'

if Meteor.isClient
	window.Config = Config

if Meteor.isServer
	global.Config = Config