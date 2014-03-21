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
                    'dist/jsonexplorer.js': ['src/*.coffee']

        karma:
            client:
                options:
                    browsers: ['Chrome']
                    frameworks: ['mocha','sinon-chai']
                    singleRun: true
                    preprocessors:
                        'src/*.coffee': 'coffee'
                    files: [
                        'bower_components/angular/angular.js'
                        'src/test.coffee'
                    ]

    grunt.registerTask 'default', 'Perform all code build tasks',
        ['stylus:all','karma:client', 'coffee:client']

    grunt.finalize()
