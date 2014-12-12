replace = require 'replace'
chomp = require 'chomp'
exec = require('child_process').exec

module.exports = class GitDigest

  brunchPlugin: true

  constructor: (@config) ->

  onCompile: ->
    return unless @config.bustCache
    @execute 'git rev-parse --short HEAD', @replace

  execute: (command, callback) ->
    exec command, (error, stdout, stderr) -> callback stdout

  replace: (digest) =>
    replace
      regex: /\?CACHEBUSTER/g
      replacement: '?' + digest.chomp()
      paths: [@config.paths.public]
      recursive: true
      silent: true
