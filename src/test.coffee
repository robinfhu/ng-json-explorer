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


