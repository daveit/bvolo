Schemas = {}

Items = new Meteor.Collection('items');

Schemas.Items = new SimpleSchema
	id:
		type:String
		max: 60

	name:
		type: String

	image:
		type: String

	units:
		label: 'Units of measurement'
		type: [String]

	category: 
		type: String
		regEx: SimpleSchema.RegEx.Id
		autoform:
			options: ->
				_.map Categories.find().fetch(), (category)->
					label: category.name
					value: category._id

	unavailable:
		type: Boolean
		label: 'Out of season'

Items.attachSchema(Schemas.Items)

if Meteor.isClient
	window.Items = Items
else if Meteor.isServer
	global.Items = Items