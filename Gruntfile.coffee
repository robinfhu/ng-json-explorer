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

    grunt.registerTask 'default', 'Perform all code build tasks',
        ['stylus:all','coffee:client']

    grunt.finalize()
