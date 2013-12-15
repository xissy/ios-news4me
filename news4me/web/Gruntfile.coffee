
module.exports = (grunt) ->
  for key of grunt.file.readJSON('package.json').devDependencies
    if key isnt 'grunt' and key.indexOf('grunt') is 0
      grunt.loadNpmTasks key
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      options:
        bare: true
      dev:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'src/'
          src: [
            '**/*.coffee'
          ]
          dest: 'dist/'
          ext: '.js'
        ]

    jade:
      options:
        pretty: true
      dev:
        files: [
          expand: true
          cwd: 'src/'
          src: [
            '**/*.jade'
          ]
          dest: 'dist/'
          ext: '.html'
        ]

    less:
      dev:
        options:
          yuicompress: false
        files: [
          expand: true
          cwd: 'src/'
          src: [
            '**/*.less'
          ]
          dest: 'dist/'
          ext: '.css'
        ]

    copy:
      dev_resources:
        files: [
          expand: true
          dot: true
          cwd: 'src/'
          dest: 'dist/'
          src: [
            '**/*'
            '!**/*.coffee'
            '!**/*.less'
            '!**/*.jade'
          ]
        ]

    clean: 
      dev: [ 'dist/' ]


  grunt.registerTask 'default', [
    'build'
  ]

  grunt.registerTask 'build', [
    # 'clean:dev'
    'coffee:dev'
    'jade:dev'
    'less:dev'
    'copy:dev_resources'
  ]
