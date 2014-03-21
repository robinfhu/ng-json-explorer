describe 'JSON Explorer Tests', ->
	describe 'module', ->
		it 'should exist', ->
			angular.module('gd.ui.jsonexplorer').should.have.property 'controller'

	describe 'directive', ->
		beforeEach ->
			angular.mock.module 'gd.ui.jsonexplorer'

		create = (data)->
			elem = render 'json-explorer', {data}, {'json-data':'data'}

			elem[0].querySelector '.gd-ui-json-explorer'

		it 'should create a <div>', ->
			element = create({})

			should.exist element

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


