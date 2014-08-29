Schemas = {}

Categories = new Meteor.Collection('categories');

Schemas.Categories = new SimpleSchema
	name:
		type: String

Categories.attachSchema(Schemas.Categories)

if Meteor.isClient
	window.Categories = Categories
else if Meteor.isServer
	global.Categories = Categories