Meteor.methods
	alertOrder: (_id)->
		order = Orders.findOne {_id:_id}
		console.log order