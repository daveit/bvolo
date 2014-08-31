Meteor.publish 'items', ->
	Items.find()

Meteor.publish 'categories', ->
	Categories.find()

Meteor.publish 'orders', ->
	Orders.find {owner: @userId}

Meteor.publish 'reports', ->
	Reports.find()

Meteor.publish 'posts', ->
	Posts.find()
