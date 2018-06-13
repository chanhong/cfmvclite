Inspired by Ben Nadel (http://www.bennadel.com) Learning MVC (Model-View-Controller) Architecture In ColdFusion and by https://www.amazon.com/Fast-Track-ColdFusion-10-11/dp/1515067777/

This skeleton has the basic set of files that help you get started with main site and subsite in the apps folder

copy docs\mainsite_skeleton to yoursite

You must have the "scfcs" folder which is the core of mvclite

You will also need to create the standard folders such as: assets, layouts, controllers, views, models, etc

This is a work in progress...

Features:

. The goal is try to provide a mean to reuse code when you want to use MVC layer.

. Shared MVC layer with subsite apps via the ApplicationProxy.cfc (see docs for sample)

. MVC consister of a handful of shared cfc such as: Loader to load cfc, Router, Helper, Utility, etc

. Option to use DAO https://github.com/abramadams/dao

. Use JQuery, Bootstrap, Telerik Kendo-UI core https://github.com/telerik/kendo-ui-core

. Utilizing ColdFusion life cycle and MVC will only do something when it detect the url with action of cfc or cfm, otherwise it will pass on to the normal ColdFusion live cycle.



Need work:

. Incomplete shared basemodel.cfc, it only has read and still need insert, update and delete (CRUD)




