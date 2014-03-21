angular.module('gd.ui.jsonexplorer', [])
.directive 'jsonExplorer', ->
	restrict: 'EA'
	scope:
		jsonData: '=jsonData'
	template: '<div class="gd-ui-json-explorer"></div>'
	link: (scope, elem, attrs)->
		mainContainer = elem.find('div')

		countProperties = (data)->
			count = 0
			for key of data
				count++

			count


		processData = (data,container)->
			if data instanceof Array
				container.text '[]'
			else if data instanceof Object
				numProps = countProperties data
				isEmpty = numProps is 0

				container.append '{'

				if not isEmpty
					ul = angular.element document.createElement 'ul'
					ul.addClass 'obj collapsible'

					index = 0
					for key,val of data
						li = angular.element document.createElement 'li'
						ul.append li
						li.append "<span class='prop'>#{key}</span>"
						li.append ': &nbsp;'

						processData val, li

						index++
						if index < numProps
							li.append ','


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

		processData scope.jsonData, mainContainer

