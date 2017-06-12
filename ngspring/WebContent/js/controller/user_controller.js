var ctrlModule = angular.module("CtrlModule",[]);
ctrlModule.controller("UserController",["$scope","UserService",function($scope,UserService){
	$scope.user = {id:null,username:'',address:'',email:''};
	$scope.users = [];
	$scope.error = "";//该变量用来提示新增用户名存在
	$scope.errors= "";//该变量用来提示修改用户名存在
	$scope.fetchAllUsers = function(){
		UserService.fetchAllUsers()
			.then(
					function(response){
						console.info(response);
						$scope.users = response.data.resultData;
					},function(errResponse){
						console.log("无记录");
					}
			);
	};
	
	$scope.fetchAllUsers();
	$scope.reset = function(){
		$scope.user = {id:null,username:'',address:'',email:''};
		$scope.myForm.$setPristine();
	};
	$scope.createUser = function(user){
		UserService.createUser(user)
			.then(
					$scope.fetchAllUsers,
					function(errResponse){
						$scope.error = errResponse.data.message;
					}
			);
	};
	$scope.updateUser = function(user){
		UserService.updateUser(user)
			.then(
					$scope.fetchAllUsers,//避免第一次修改时，不能即可刷新，所以将fetchAllUsers()改为fetchAllUsers
					function(errResponse){
						$scope.errors=errResponse.data.message;
					}
			);
	};
	
	$scope.deleteUser = function(id){
		UserService.deleteUser(id)
			.then(
					$scope.fetchAllUsers,
					function(errResponse){
						console.log(errResponse.data.message);
					}
			);
	};
	
	$scope.submit = function(){
		if($scope.user.id == null){
			$scope.createUser($scope.user);
		}else{
			$scope.updateUser($scope.user);
		}
		//提交以后重置表单，以免重复提交表单
		$scope.reset();
		$scope.error = "";
	};
	
	$scope.edit = function(id){
		
		for(var i = 0;i< $scope.users.length;i++){
			if($scope.users[i].id == id){
				$scope.errors="";
				$scope.user = angular.copy($scope.users[i]);
				break;
			}
		}
	};
	$scope.remove = function(id){
		if($scope.user.id == id){
			$scope.reset();
		}
		$scope.deleteUser(id);
	};
}]);