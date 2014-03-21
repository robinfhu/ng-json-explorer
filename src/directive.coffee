angular.module('gd.ui.jsonexplorer', [])
.directive 'jsonExplorer', ->
	restrict: 'EA'
	scope:
		jsonData: '=jsonData'
	template: '<div class="gd-ui-json-explorer"></div>'
	link: (scope, elem, attrs)->
		data = scope.jsonData
		container = elem.find('div')

		if data instanceof Array
			container.text '[]'
		else if data instanceof Object
			container.text '{}'

