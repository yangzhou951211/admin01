var serviceModule = angular.module("ServiceModule",[]);
serviceModule.factory("UserService",["$http",function($http){
	return{
		fetchAllUsers : function(){
			return $http.get("http://localhost:8080/ngspring/user/fetchAllUsers");
			
		},
	
		createUser : function(user){
			return $http.post("http://localhost:8080/ngspring/user/add",user);
			
		},
		
		updateUser : function(user){
			return $http.post("http://localhost:8080/ngspring/user/update",user);
				
		},
		
		deleteUser : function(id){
			return $http.delete("http://localhost:8080/ngspring/user/delete/"+id);
				
		}
	};
}]);