AdminDashboard =
	schemas: {}
	alertSuccess: (message)->
		alert 'Success ' + message
	alertFailure: (message)->
		alert 'Failure ' + message
	checkAdmin: ->
		if not Roles.userIsInRole Meteor.userId(), ['admin']
			Meteor.call 'adminCheckAdmin'
	adminRoutes: ['adminDashboard','adminDashboardUsersNew','adminDashboardUsersView','adminDashboardUsersEdit','adminDashboardView','adminDashboardNew','adminDashboardEdit','adminDashboardDetail']
	collectionLabel: (collection)->
		if collection == 'Users'
			'Users'
		else if collection? and typeof AdminConfig.collections[collection].label == 'string'
			AdminConfig.collections[collection].label
		else Session.get 'admin_collection'


AdminDashboard.schemas.newUser = new SimpleSchema
	email: 
		type: String
		label: "Email address"
	username:
		type: String
	chooseOwnPassword:
		type: Boolean
		label: 'Let this user choose their own password with an email'
		defaultValue: true
	password:
		type: String
		label: 'Password'
		optional: true
	sendPassword:
		type: Boolean
		label: 'Send this user their password by email'
		optional: true

AdminDashboard.schemas.sendResetPasswordEmail = new SimpleSchema
	_id:
		type: String

AdminDashboard.schemas.changePassword = new SimpleSchema
	_id:
		type: String
	password:
		type: String
