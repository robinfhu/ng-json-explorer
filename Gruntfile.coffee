module.exports = (grunt)->
    require('grunt-recurse')(grunt, __dirname)

    grunt.Config =
        stylus:
            all:
                files:
                    'dist/all.css': ['style/all.styl']
        coffee:
            options:
                bare: false
            client:
                files:
                    'dist/jsonexplorer.js': ['src/directive.coffee']

        karma:
            client:
                options:
                    browsers: ['Chrome']
                    frameworks: ['mocha','sinon-chai']
                    reporters: [ 'spec', 'junit']
                    junitReporter:
                        outputFile: 'karma.xml'
                    singleRun: true
                    preprocessors:
                        'src/*.coffee': 'coffee'
                        'tools/*.coffee': 'coffee'
                    files: [
                        'bower_components/angular/angular.js'
                        'bower_components/angular-mocks/angular-mocks.js'
                        'tools/*.coffee'
                        'src/*.coffee'
                    ]

    grunt.registerTask 'default', 'Perform all code build tasks',
        ['stylus:all','karma:client', 'coffee:client']

    grunt.finalize()
