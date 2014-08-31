Schemas = {}

Schemas.UserProfile = new SimpleSchema(
  companyName:
    type: 'String'
    optional: true
  
)

Schemas.User = new SimpleSchema(
  
  username:
    type: String

  emails:
    type: [Object]

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email

  "emails.$.verified":
    type: Boolean

  createdAt:
    type: Date

  profile:
    type: Schemas.UserProfile
    optional: true

  services:
    type: Object
    optional: true
    blackbox: true

  roles:
    type: [String]
    blackbox: true
    optional: true
)

Meteor.users.attachSchema Schemas.User
