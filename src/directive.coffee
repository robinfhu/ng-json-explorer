angular.module('gd.ui.jsonexplorer', [])
.directive 'jsonExplorer', ->
	restrict: 'EA'
	scope:
		jsonData: '=jsonData'
	template: '<div class="gd-ui-json-explorer"></div>'
	link: (scope, elem, attrs)->
		mainContainer = elem.find('div')

		# figure out how many properties are in an object
		countProperties = (data)->
			count = 0
			for key of data
				count++

			count

		###
		Recursively process a JSON object.
		Renders a DOM structure that looks nice to the user
		###
		processData = (data,container)->
			if data instanceof Array   # handle arrays
				container.append '['

				if data.length > 0
					ul = angular.element document.createElement 'ul'
					ul.addClass 'array collapsible'

					for val,index in data
						li = angular.element document.createElement 'li'
						li.append "#{index}: &nbsp;"
						processData val, li

						if index < (data.length - 1)
							li.append ','

						ul.append li

					container.append ul

				container.append ']'

			else if data instanceof Object   # handle objects
				numProps = countProperties data
				isEmpty = numProps is 0

				container.append '{'

				if not isEmpty
					ul = angular.element document.createElement 'ul'
					ul.addClass 'obj collapsible'

					index = 0
					for key,val of data
						li = angular.element document.createElement 'li'

						li.append "<span class='prop'>#{key}</span>"
						li.append ': &nbsp;'

						processData val, li

						index++
						if index < numProps
							li.append ','

						ul.append li

					container.append ul

				container.append '}'

			# Handle primitives
			else if typeof data is 'number'
				container.append "<span class='num'>#{data}</span>"
			else if typeof data is 'string'
				container.append "<span class='string'>\"#{data}\"</span>"
			else if typeof data is 'boolean'
				container.append "<span class='bool'>#{data}</span>"
			else if not data?
				container.append "<span class='null'>null</span>"

		processData scope.jsonData, mainContainer

