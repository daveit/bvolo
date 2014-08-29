Meteor.publish 'items', ->
	Items.find()

Meteor.publish 'categories', ->
	Categories.find()

Meteor.publish 'orders', ->
	Orders.find()