(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
// packages/admin-dashboard/lib/both/AdminDashboard.coffee.js                                                          //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
                   

AdminDashboard = {
  schemas: {},
  alertSuccess: function(message) {
    return alert('Success ' + message);
  },
  alertFailure: function(message) {
    return alert('Failure ' + message);
  },
  checkAdmin: function() {
    if (!Roles.userIsInRole(Meteor.userId(), ['admin'])) {
      return Meteor.call('adminCheckAdmin');
    }
  },
  adminRoutes: ['adminDashboard', 'adminDashboardUsersNew', 'adminDashboardUsersView', 'adminDashboardUsersEdit', 'adminDashboardView', 'adminDashboardNew', 'adminDashboardEdit', 'adminDashboardDetail'],
  collectionLabel: function(collection) {
    if (collection === 'Users') {
      return 'Users';
    } else if ((collection != null) && typeof AdminConfig.collections[collection].label === 'string') {
      return AdminConfig.collections[collection].label;
    } else {
      return Session.get('admin_collection');
    }
  }
};

AdminDashboard.schemas.newUser = new SimpleSchema({
  email: {
    type: String,
    label: "Email address"
  },
  chooseOwnPassword: {
    type: Boolean,
    label: 'Let this user choose their own password with an email',
    defaultValue: true
  },
  password: {
    type: String,
    label: 'Password',
    optional: true
  },
  sendPassword: {
    type: Boolean,
    label: 'Send this user their password by email',
    optional: true
  }
});

AdminDashboard.schemas.sendResetPasswordEmail = new SimpleSchema({
  _id: {
    type: String
  }
});

AdminDashboard.schemas.changePassword = new SimpleSchema({
  _id: {
    type: String
  },
  password: {
    type: String
  }
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
// packages/admin-dashboard/lib/both/router.coffee.js                                                                  //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Router.map(function() {
  this.route("adminDashboard", {
    path: "/admin",
    template: "AdminDashboard",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminUsers', Meteor.subscribe('adminAllCollections'))];
    },
    action: function() {
      Session.set('admin_title', 'Dashboard');
      Session.set('admin_collection', '');
      Session.set('admin_collection_page', '');
      return this.render();
    }
  });
  this.route("adminDashboardUsersNew", {
    path: "/admin/Users/new",
    template: "AdminDashboardUsersNew",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return Meteor.subscribe('adminUsers');
    },
    action: function() {
      Session.set('admin_title', 'Users');
      Session.set('admin_subtitle', 'Create new user');
      Session.set('admin_collection_page', 'New');
      Session.set('admin_collection', 'Users');
      return this.render();
    }
  });
  this.route("adminDashboardUsersView", {
    path: "/admin/Users/",
    template: "AdminDashboardUsersView",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminUsers')];
    },
    data: function() {
      return {
        users: Meteor.users.find({}, {
          sort: {
            createdAt: -1
          }
        }).fetch()
      };
    },
    action: function() {
      Session.set('admin_title', 'Users');
      Session.set('admin_subtitle', 'View users');
      Session.set('admin_collection_page', '');
      Session.set('admin_collection', 'Users');
      return this.render();
    }
  });
  this.route("adminDashboardUsersEdit", {
    path: "/admin/Users/:_id/edit",
    template: "AdminDashboardUsersEdit",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminUsers')];
    },
    data: function() {
      return {
        user: Meteor.users.find({
          _id: this.params._id
        }).fetch(),
        roles: Roles.getRolesForUser(this.params._id),
        otherRoles: _.difference(_.map(Meteor.roles.find().fetch(), function(role) {
          return role.name;
        }), Roles.getRolesForUser(this.params._id))
      };
    },
    action: function() {
      Session.set('admin_title', 'Users');
      Session.set('admin_subtitle', 'Edit user ' + this.params._id);
      Session.set('admin_collection_page', 'edit');
      Session.set('admin_collection', 'Users');
      Session.set('admin_id', this.params._id);
      Session.set('admin_doc', Meteor.users.findOne({
        _id: this.params._id
      }));
      return this.render();
    }
  });
  this.route("adminDashboardView", {
    path: "/admin/:collection/",
    template: "AdminDashboardView",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminCollection', this.params.collection), Meteor.subscribe('adminAuxCollections', this.params.collection), Meteor.subscribe('adminUsers')];
    },
    data: function() {
      return {
        documents: window[this.params.collection].find({}, {
          sort: {
            createdAt: -1
          }
        }).fetch()
      };
    },
    action: function() {
      Session.set('admin_title', AdminDashboard.collectionLabel(this.params.collection));
      Session.set('admin_subtitle', 'View ');
      Session.set('admin_collection_page', '');
      Session.set('admin_collection', this.params.collection.charAt(0).toUpperCase() + this.params.collection.slice(1));
      return this.render();
    }
  });
  this.route("adminDashboardNew", {
    path: "/admin/:collection/new",
    template: "AdminDashboardNew",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminAuxCollections', this.params.collection), Meteor.subscribe('adminUsers')];
    },
    action: function() {
      Session.set('admin_title', AdminDashboard.collectionLabel(this.params.collection));
      Session.set('admin_subtitle', 'Create new');
      Session.set('admin_collection_page', 'new');
      Session.set('admin_collection', this.params.collection.charAt(0).toUpperCase() + this.params.collection.slice(1));
      return this.render();
    }
  });
  return this.route("adminDashboardEdit", {
    path: "/admin/:collection/:_id/edit",
    template: "AdminDashboardEdit",
    layoutTemplate: "AdminLayout",
    waitOn: function() {
      return [Meteor.subscribe('adminCollection', this.params.collection), Meteor.subscribe('adminAuxCollections', this.params.collection), Meteor.subscribe('adminUsers')];
    },
    action: function() {
      Session.set('admin_title', AdminDashboard.collectionLabel(this.params.collection));
      Session.set('admin_subtitle', 'Edit ' + this.params._id);
      Session.set('admin_collection_page', 'edit');
      Session.set('admin_collection', this.params.collection.charAt(0).toUpperCase() + this.params.collection.slice(1));
      Session.set('admin_id', this.params._id);
      Session.set('admin_doc', window[this.params.collection].findOne({
        _id: this.params._id
      }));
      return this.render();
    }
  });
});

Router.onBeforeAction(AdminDashboard.checkAdmin, {
  only: AdminDashboard.adminRoutes
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
// packages/admin-dashboard/lib/server/publish.coffee.js                                                               //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.publish('adminCollection', function(collection) {
  if (Roles.userIsInRole(this.userId, ['admin'])) {
    return global[collection].find();
  } else {
    return this.ready();
  }
});

Meteor.publish('adminAuxCollections', function(collection) {
  var subscriptions;
  if (Roles.userIsInRole(this.userId, ['admin'])) {
    if (typeof AdminConfig !== 'undefined' && typeof AdminConfig.collections[collection].auxCollections === 'object') {
      subscriptions = [];
      _.each(AdminConfig.collections[collection].auxCollections, function(collection) {
        return subscriptions.push(global[collection].find());
      });
      return subscriptions;
    } else {
      return this.ready();
    }
  } else {
    return this.ready();
  }
});

Meteor.publish('adminAllCollections', function() {
  var subscriptions;
  if (Roles.userIsInRole(this.userId, ['admin'])) {
    if (typeof AdminConfig !== 'undefined' && typeof AdminConfig.collections === 'object') {
      subscriptions = [];
      _.map(AdminConfig.collections, function(obj, key) {
        return subscriptions.push(global[key].find());
      });
      return subscriptions;
    }
  } else {
    return this.ready();
  }
});

Meteor.publish('adminUsers', function() {
  if (Roles.userIsInRole(this.userId, ['admin'])) {
    return Meteor.users.find();
  } else {
    return this.ready();
  }
});

Meteor.publish(null, function() {
  return Meteor.roles.find({});
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
// packages/admin-dashboard/lib/server/methods.coffee.js                                                               //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.methods({
  adminInsertDoc: function(doc, collection) {
    var Future, fut;
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      Future = Npm.require('fibers/future');
      fut = new Future();
      global[collection].insert(doc, function(e, _id) {
        return fut['return']({
          e: e,
          _id: _id
        });
      });
      return fut.wait();
    }
  },
  adminUpdateDoc: function(modifier, collection, _id) {
    var Future, fut;
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      Future = Npm.require('fibers/future');
      fut = new Future();
      global[collection].update({
        _id: _id
      }, modifier, function(e, r) {
        return fut['return']({
          e: e,
          r: r
        });
      });
      return fut.wait();
    }
  },
  adminRemoveDoc: function(collection, _id) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      if (collection === 'Users') {
        return Meteor.users.remove({
          _id: _id
        });
      } else {
        return global[collection].remove({
          _id: _id
        });
      }
    }
  },
  adminNewUser: function(doc) {
    var emails;
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      emails = doc.email.split(',');
      return _.each(emails, function(email) {
        var user, _id;
        user = {};
        user.email = email;
        if (!doc.chooseOwnPassword) {
          user.password = doc.password;
        }
        _id = Accounts.createUser(user);
        if (doc.sendPassword && typeof AdminConfig.fromEmail !== 'undefined') {
          return Email.send({
            to: user.email,
            from: AdminConfig.fromEmail,
            subject: 'Your accout has been created',
            html: 'You\'ve just had an account created for ' + Meteor.absoluteUrl() + ' with password ' + doc.password
          });
        }
      });
    }
  },
  adminUpdateUser: function(modifier, _id) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      console.log(modifier);
      console.log(_id);
      return Meteor.users.update({
        _id: _id
      }, modifier, function(e, r) {});
    }
  },
  adminSendResetPasswordEmail: function(doc) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      console.log('Changing password for user ' + doc._id);
      return Accounts.sendResetPasswordEmail(doc._id);
    }
  },
  adminChangePassword: function(doc) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      console.log('Changing password for user ' + doc._id);
      Accounts.setPassword(doc._id, doc.password);
      return {
        label: 'Email user their new password'
      };
    }
  },
  adminCheckAdmin: function() {
    var adminEmails;
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      if (typeof AdminConfig !== 'undefined' && typeof AdminConfig.adminEmails === 'object') {
        adminEmails = AdminConfig.adminEmails;
        if (adminEmails.indexOf(Meteor.users.findOne({
          _id: this.userId
        }).emails[0].address) > -1) {
          console.log('Adding admin user: ' + this.userId);
          return Roles.addUsersToRoles(this.userId, ['admin']);
        }
      }
    }
  },
  adminAddUserToRole: function(_id, role) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      return Roles.addUsersToRoles(_id, role);
    }
  },
  adminRemoveUserToRole: function(_id, role) {
    if (Roles.userIsInRole(this.userId, ['admin'])) {
      return Roles.removeUsersFromRoles(_id, role);
    }
  }
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);






(function () {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
// packages/admin-dashboard/lib/server/startup.coffee.js                                                               //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                                                                                                       //
__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
Meteor.startup(function() {
  var adminEmails;
  if (typeof AdminConfig !== 'undefined' && typeof AdminConfig.adminEmails !== 'undefined') {
    adminEmails = AdminConfig.adminEmails;
    return _.each(adminEmails, function(adminEmail) {
      var _id;
      if (Meteor.users.findOne({
        emails: {
          $elemMatch: {
            address: adminEmail
          }
        }
      })) {
        console.log('User exists: ' + adminEmail);
        Roles.addUsersToRoles(Meteor.users.findOne({
          emails: {
            $elemMatch: {
              address: adminEmail
            }
          }
        })._id, ["admin"]);
      } else {
        console.log("Creating admin user " + adminEmail);
        _id = Accounts.createUser({
          email: adminEmail,
          profile: {},
          password: 'code2create'
        });
        Roles.addUsersToRoles(_id, ["admin"]);
        Accounts.sendEnrollmentEmail(_id);
      }
    });
  }
});
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}).call(this);
