describe 'JSON Explorer Tests', ->
	describe 'module', ->
		it 'should exist', ->
			angular.module('nv.ui.jsonexplorer').should.have.property 'controller'

	describe 'directive', ->
		beforeEach ->
			angular.mock.module 'nv.ui.jsonexplorer'

		create = (data)->
			elem = render 'json-explorer', {data}, {'json-data':'data'}

			elem[0].querySelector '.nv-ui-json-explorer'

		it 'should create a <div>', ->
			element = create({})

			should.exist element

		describe 'javascript primitives', ->

			it 'should show empty brackets for empty data set', ->
				element = create({})

				element.innerText.should.equal '{}'

			it 'should show empty square brackets for empty array', ->
				element = create([])

				element.innerText.should.equal '[]'

			it 'should show primitive number', ->
				element = create(123)

				span = element.querySelector 'span.num'

				should.exist span
				span.innerText.should.equal '123'

			it 'should show primitive string', ->
				element = create('hello')

				span = element.querySelector 'span.string'

				should.exist span
				span.innerText.should.equal '"hello"'

			it 'should show primitive null', ->
				element = create(null)

				span = element.querySelector 'span.null'

				should.exist span
				span.innerText.should.equal 'null'

			it 'should show primitive bool', ->
				element = create(true)

				span = element.querySelector 'span.bool'

				should.exist span
				span.innerText.should.equal 'true'

		it 'should render simple object', ->
			element = create
				hello: 123
				world: 'foo'
				chrome: null

			ul = element.querySelector 'ul.obj.collapsible'
			li = ul.querySelectorAll 'li'

			should.exist ul
			li.should.have.length 3

			prop = li[0].querySelector 'span.prop'
			value = li[0].querySelector 'span.num'

			should.exist prop, 'span.prop exists'
			should.exist value, 'span.num exists'

			prop.innerText.should.equal 'hello'
			value.innerText.should.equal '123'

			prop = li[1].querySelector 'span.prop'
			value = li[1].querySelector 'span.string'

			prop.innerText.should.equal 'world'
			value.innerText.should.equal '"foo"'

			prop = li[2].querySelector 'span.prop'
			value = li[2].querySelector 'span.null'

			prop.innerText.should.equal 'chrome'
			value.innerText.should.equal 'null'


			li[0].innerText.should.contain ':', 'there should be a colon'
			li[0].innerText.should.contain ',', 'there should be a comma'
			li[2].innerText.should.not.contain ',',  'last item has no comma'

		it 'should render a simple array', ->
			element = create [123,'hello',false,null,'world']

			ul = element.querySelector 'ul.array.collapsible'
			li = ul.querySelectorAll 'li'

			should.exist ul
			li.should.have.length 5

			li[0].innerText.should.contain '0:', 'index number 0'
			li[1].innerText.should.contain '1:', 'index number 1'
			li[2].innerText.should.contain '2:', 'index number 2'
			li[3].innerText.should.contain '3:', 'index number 3'
			li[4].innerText.should.contain '4:', 'index number 4'

			li[0].innerText.should.contain ',', 'comma'
			li[3].innerText.should.contain ','
			li[4].innerText.should.not.contain ',', 'no comma on last item'

			value = li[0].querySelector 'span.num'
			should.exist value

			value.innerText.should.equal '123'

			value = li[1].querySelector 'span.string'
			value.innerText.should.equal '"hello"'

			value = li[2].querySelector 'span.bool'
			value.innerText.should.equal 'false'

			value = li[3].querySelector 'span.null'
			value.innerText.should.equal 'null'

		it 'should render nested object', ->
			element = create
				nested:
					hello: 4321
					foo: 'bar'

			nestedUl = element.querySelector 'ul.obj li ul.obj'
			should.exist nestedUl

			nestedUl.querySelectorAll('li').should.have.length 2
			nestedUl.className.should.contain 'hide'

			collapser = element.querySelector 'ul.obj li .collapser'

			should.exist collapser
			collapser.innerText.should.equal '+'

			ellipsis = element.querySelector 'ul.obj li .ellipsis'

			should.exist ellipsis

		it 'should not show collapser for null value', ->
			element = create
				hello: null

			collapser = element.querySelector 'ul.obj li .collapser'

			should.not.exist collapser

		it 'has mode to expand all nested objects', ->
			data =
				nested:
					hello: 4321
					foo: 'bar'

			elem = render 'json-explorer', {data}, {
				'json-data':'data',
				'expand': 'expand'
			}

			explorer = elem[0].querySelector '.nv-ui-json-explorer'

			nested = explorer.querySelector 'ul.obj li ul.obj'
			nested.className.should.not.contain 'hide'

			collapser = explorer.querySelector 'ul.obj li .collapser'
			collapser.textContent.should.equal '-'

		it 'has option to limit array lengths', ->
			data = [
				'a'
				'b'
				'c'
				'd'
				'e'
			]

			elem = render 'json-explorer', {data}, {
				'json-data':'data',
				'array-limit': '3'
			}

			explorer = elem[0].querySelector '.nv-ui-json-explorer'

			arrayElems = explorer.querySelectorAll 'ul.array li'
			arrayElems.length.should.equal 3

		describe 'clicking the collapser', ->
			it 'should show object contents when clicked', ->
				element = create
					nested:
						hello: 4321
						foo: 'bar'


				collapser = element.querySelector 'ul.obj li .collapser'
				nestedUl = element.querySelector 'ul.obj li ul.obj'
				ellipsis = element.querySelector 'ul.obj li .ellipsis'

				collapser.click()

				collapser.innerText.should.equal '-'
				nestedUl.className.should.not.contain 'hide'
				ellipsis.className.should.contain 'hide'

				collapser.click()

				collapser.innerText.should.equal '+'
				nestedUl.className.should.contain 'hide'
				ellipsis.className.should.not.contain 'hide'

			it 'hides the correct ellipsis', ->
				element = create
					nested:
						hello: 'world'
						foo:
							bar: 123

				collapser = element.querySelector 'ul.obj li .collapser'

				collapser.click()

				ellipsis = element.querySelectorAll 'ul.obj li .ellipsis'

				ellipsis.should.have.length 2

				ellipsis[0].className.should.not.contain 'hide'
				ellipsis[1].className.should.contain 'hide'

			it 'should show collapser for object in array', ->
				element = create [
					nested: '10'
				]

				collapser = element.querySelector 'ul.array li .collapser'

				should.exist collapser

				nestedUl = element.querySelector 'ul.array li ul.obj'
				ellipsis = element.querySelector 'ul.array li .ellipsis'

				nestedUl.className.should.contain 'hide'
				ellipsis.className.should.not.contain 'hide'

		describe 'scope watch', ->
			it 'should update when scope variable changes', ->
				data = {}
				elem = render 'json-explorer', {data}, {'json-data':'data'}

				elem[0].innerText.should.contain '{}'

				scope = elem.scope()

				scope.data = []

				scope.$digest()

				elem[0].innerText.should.contain '[]'
				elem[0].innerText.should.not.contain '{}'

			it 'should handle circular reference (objects)', (done)->
				data =
					hello: 'world'

				data.circlular = data

				element = create data

				should.exist element

				done()

			it 'should handle circular reference (arrays)', (done)->
				data = [
					'hello'
				]

				data.push data

				element = create data

				should.exist element

				done()

