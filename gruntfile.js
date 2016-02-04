module.exports = function(grunt) {
  // Project Configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      sass: {
        files: ['public/assets/css/sass/*.scss'],
        tasks: 'sass'
      },
      concat: {
        files: ['<%= concat.dist.src %>', '<%= concat.dist.dest %>'],
        tasks: 'concat'
      },
      uglify: {
        files: ['<%= uglify.build.src %>', '<%= uglify.build.dest %>'],
        tasks: 'uglify'
      },
      js: {
        files: ['public/assets/js/**', 'src/assets/js/*.js'],
        tasks: ['jshint']
      }
    },
    sass: {
      dist: {
        files: {
          'public/assets/css/main.css': 'public/assets/css/sass/main.scss'
        }
      }
    },
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'public/assets/js/main.js',
        dest: 'public/assets/js/main.min.js'
      }
    },
    concat: {
      options: {
        separator: ';'
      },
      dist: {
        src: ['public/assets/js/vendor/*.js', 'public/assets/js/app.js'],
        dest: 'public/assets/js/main.js'
      }
    },
    jshint: {
      all: ['gruntfile.js', 'src/js/main.js']
    }
  });

  //Load NPM tasks
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-jshint');

  //Making grunt default to force in order not to break the project.
  grunt.option('force', true);
  
  // Default task(s).
  grunt.registerTask('default', ['sass','concat', 'uglify', 'jshint', 'watch']);

};
