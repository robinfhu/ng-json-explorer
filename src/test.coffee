should = chai.should()

describe 'JSON Explorer Tests', ->
	describe 'module', ->
		it 'should exist', ->
			angular.module('gd.ui.jsonexplorer').should.have.property 'controller'


	describe 'directive', ->
		beforeEach ->
			angular.mock.module 'gd.ui.jsonexplorer'

		it 'should create a <div>', ->
			data = {}
			element = render 'json-explorer', {data}, {'json-data':'data'}

			should.exist element[0].querySelector '.gd-ui-json-explorer'

