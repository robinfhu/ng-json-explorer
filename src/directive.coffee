angular.module('gd.ui.jsonexplorer', [])
.directive 'jsonExplorer', ->
	restrict: 'EA'
	scope:
		jsonData: '=jsonData'
	template: '<div class="gd-ui-json-explorer"></div>'
	link: (scope, elem, attrs)->

