var kuvera = angular.module('kuvera',[]);

kuvera.config(["$httpProvider", function($httpProvider) {
	$httpProvider.defaults.headers.common['X-CSRF-Token'] =
	$('meta[name=csrf-token]').attr('content');
	$httpProvider.defaults.headers.common['X-Requested-With'] = 'AngularXMLHttpRequest'
}]);

kuvera.controller("amcController", ["$scope", "$http", "$filter", function($scope, $http, $filter) {
	$scope.init = function() {
		$scope.all_scheme_names = all_scheme_names;
		$scope.invested = 0
		$scope.worth = 0
		$scope.profit = 0
	}
	$scope.init();
	$scope.plans = [{}];
	$scope.newScheme = function(){
		$scope.plans.push({});
	}
	$scope.removeScheme = function(index){
		if($scope.plans.length>1){
			$scope.plans.splice(index, 1);
		}
	}
	$scope.checkSchemeValue = function(plan,index){
		if(plan.scheme_name && plan.date && plan.invested){
			plan.on_date = $filter('date')(plan.date , "dd-MM-yyyy");
			$http.post("/checkSchemeValue", plan).then(function(res) {
				$scope.plans[index].units = res.data.units;
				$scope.plans[index].today = res.data.today;
			});
		}
	}
	$scope.totalValue = function(plans){
		$scope.invested = 0
		$scope.worth = 0
		$scope.profit = 0
		angular.forEach(plans, function(plan) {
			$scope.invested = $scope.invested + plan.invested 
			$scope.worth = $scope.worth + plan.today 
		})
		$scope.profit = $scope.worth - $scope.invested	
	}
}])