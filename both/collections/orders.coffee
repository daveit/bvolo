Schemas = {}

Schemas.OrderRow = new SimpleSchema(
	item:
		type: String
		autoform:
			options: ->
				_.map Items.find().fetch(), (item)->
					label: item.name
					value: item._id

	unit:
		type: String

	quantity:
		type: Number
)

Orders = new Meteor.Collection('orders');

Schemas.Orders = new SimpleSchema
	owner: 
		type: String
		autoValue: ->
			if this.isInsert
				return Meteor.userId()
		autoform:
			options: ->
				_.map Meteor.users.find().fetch(), (user)->
					label: user.emails[0].address
					value: user._id


	orderNumber:
		type: String
		optional: true

	deliverBy:
		type: Date

	comments:
		type: String
		optional:true
		autoform:
			rows: 3

	item:
		type: [Schemas.OrderRow]

	reference:
		type: Number
		optional: true
		
	finalized:
		type: Boolean

Orders.attachSchema(Schemas.Orders)

if Meteor.isClient
	window.Orders = Orders
else if Meteor.isServer
	global.Orders = Orders
