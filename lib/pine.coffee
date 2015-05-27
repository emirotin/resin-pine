_ = require('lodash')
Promise = require('bluebird')
PinejsClientCore = require('pinejs-client/core')(_, Promise)
errors = require('resin-errors')
request = require('./request')
utils = require('./utils')

class ResinPine extends PinejsClientCore

	_request: (params) ->
		params.json = true
		params.gzip ?= true

		# Support "data" attribute
		if params.data? and not params.body?
			params.body = params.data

		request(params).spread (response, body) ->
			return body if utils.isSuccessfulResponse(response)
			throw new errors.ResinRequestError(body)

module.exports = new ResinPine
	apiPrefix: '/ewa/'
