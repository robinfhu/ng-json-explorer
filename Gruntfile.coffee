module.exports = (grunt)->
    require('grunt-recurse')(grunt, __dirname)

    grunt.Config =
        stylus:
            all:
                files:
                    'dist/all.css': ['style/all.styl']

    grunt.registerTask 'default', 'Perform all code build tasks', ['stylus:all']

    grunt.finalize()
