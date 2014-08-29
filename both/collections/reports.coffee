Schemas = {}

Reports = new Meteor.Collection('reports');

Schemas.Reports = new SimpleSchema
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

Reports.attachSchema(Schemas.Reports)

if Meteor.isClient
	window.Reports = Reports
else if Meteor.isServer
	global.Reports = Reports