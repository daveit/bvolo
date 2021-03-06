Schemas = {}

Posts = new Meteor.Collection('posts');

Schemas.Posts = new SimpleSchema
	title:
		type:String
		max: 60

	content:
		type: String
		autoform:
			rows: 10

	createdAt: 
		type: Date
		autoValue: ->
			if this.isInsert
				new Date()

Posts.attachSchema(Schemas.Posts)

if Meteor.isClient
	window.Posts = Posts
else if Meteor.isServer
	global.Posts = Posts