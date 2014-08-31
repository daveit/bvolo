Accounts.config
  sendVerificationEmail : true

if Meteor.isClient
  Meteor.startup ->
    AccountsEntry.config
      homeRoute: '/'
      dashboardRoute: '/'
      profileRoute: 'profile'
      passwordSignupFields: 'USERNAME_AND_EMAIL'
      extraSignUpFields: [
      	field: "companyName"
      	label: "Company Name"
      	type: "text"
      	required: true
      ]

if Meteor.isServer
  Accounts.emailTemplates.siteName = Config.siteName
  Accounts.emailTemplates.from = Config.fromEmail