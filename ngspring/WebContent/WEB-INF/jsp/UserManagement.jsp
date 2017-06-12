<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AngularJS $http Example</title>  
    <style>
      .username.ng-valid {
          background-color: lightgreen;
      }
      .username.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .username.ng-dirty.ng-invalid-minlength {
          background-color: yellow;
      }

      .email.ng-valid {
          background-color: lightgreen;
      }
      .email.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .email.ng-dirty.ng-invalid-email {
          background-color: yellow;
      }
    </style>
     <link rel="stylesheet" href="css/bootstrap-3.3.5/css/bootstrap.min.css">
</head>
 <body ng-app="myApp" class="ng-cloak">
      <div class="container" ng-controller="UserController">
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">User Registration Form </span></div>
              <div class="formcontainer">
                  <form name="myForm" ng-submit="submit()" class="form-horizontal" novalidate>
                  	  <input type="hidden" 	ng-model="user.id"  />
                     
                      <div class="row" style="width:99%;margin:0 auto;">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="uname">Name</label>
                              <div class="col-md-7">
                                  <input type="text" 
                                  		id="uname" 
                                  		name="uname"
                                  		class="username form-control input-sm" 
                                  		placeholder="Enter your name" 
                                  		ng-model="user.username"
                                  		required
                                  		ng-minlength="3"
                                  		ng-maxlength="10"
                                  		/>
                                  <span>{{error}}</span>
                                   <span>{{errors}}</span>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uname.$error.required">请输入用户名</span>
                                      <span ng-show="myForm.uname.$error.minlength">最少输入三位</span>
                                      <span ng-show="myForm.uname.$error.maxlength">最多输入十位</span>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <div class="row" style="width:99%;margin:0 auto;">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="address">Address</label>
                              <div class="col-md-7">
                                  <input type="text" 
                                   		id="address" 
                                   		class="form-control input-sm" 
                                   		placeholder="Enter your Address."
                                   		ng-model="user.address"
                                   		/>
                              </div>
                          </div>
                      </div>

                      <div class="row" style="width:99%;margin:0 auto;">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="email">Email</label>
                              <div class="col-md-7">
                                  <input type="email"  
                                  		id="email" 
                                  		class="email form-control input-sm" 
                                  		placeholder="Enter your Email"
                                  		name="email"
                                  		ng-model="user.email"
                                  		required
                                  		/>
                                  <div class="has-error" ng-show="myForm.$dirty" >
                                      <span ng-show="myForm.email.$error.required">请输入邮箱</span>
                                      <span ng-show="myForm.email.$error.email">邮箱格式不正确</span>
                                  </div>
                              </div>
                          </div>
                      </div>

                      <div class="row" style="width:99%;margin:0 auto;">
                          <div class="form-actions floatRight">
                              <input type="submit"  
                              		class="btn btn-primary btn-sm" 
                              		value="{{!user.id?'Add':'Update'}}"
                              		ng-disabled="myForm.$invalid"
                              		/>
                              <button type="button" class="btn btn-warning btn-sm" 
                              		ng-click="reset()" 
                              		ng-disabled="myForm.$pristine">
                              		Reset Form
                              </button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
          <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Users </span></div>
              <div class="tablecontainer">
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Address</th>
                              <th>Email</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="u in users">
                              <td><span ng-bind="u.id"></span></td>
                              <td><span ng-bind="u.username"></span></td>
                              <td><span ng-bind="u.address"></span></td>
                              <td><span ng-bind="u.email"></span></td>
                              <td>
                              <button type="button" class="btn btn-success custom-width" ng-click="edit(u.id)">Edit</button> 
                              <button type="button" class="btn btn-danger custom-width" ng-click="remove(u.id)">Remove</button>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
	<script src="js/script/angular.min.js"></script>
    <script src="js/app.js"></script>
    <script src="js/service/user_service.js"></script>
    <script src="js/controller/user_controller.js"></script>
  </body>
</html>