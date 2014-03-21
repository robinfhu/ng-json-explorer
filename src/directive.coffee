angular.module('gd.ui.jsonexplorer', [])
.directive 'jsonExplorer', ->
	restrict: 'EA'
	scope:
		jsonData: '=jsonData'
	template: '<div class="gd-ui-json-explorer"></div>'
	link: (scope, elem, attrs)->
		data = scope.jsonData
		mainContainer = elem.find('div')

		processData = (data,container)->
			if data instanceof Array
				container.text '[]'
			else if data instanceof Object
				isEmpty = JSON.stringify(data) is '{}'

				container.append '{'

				if not isEmpty
					ul = angular.element document.createElement 'ul'
					ul.addClass 'obj collapsible'

					for key,val of data
						li = angular.element document.createElement 'li'
						ul.append li
						li.append "<span class='prop'>#{key}</span>"
						processData val, li

					container.append ul

				container.append '}'
			else if typeof data is 'number'
				container.append "<span class='num'>#{data}</span>"
			else if typeof data is 'string'
				container.append "<span class='string'>\"#{data}\"</span>"
			else if typeof data is 'boolean'
				container.append "<span class='bool'>#{data}</span>"
			else if not data?
				container.append "<span class='null'>null</span>"

		processData data, mainContainer

