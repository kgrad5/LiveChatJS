http = require 'http'
mu = require 'mustache'
util = require 'util'
fs = require 'fs'
path = require 'path'

start = ->
	http.createServer(requestHandler).listen(8888)	
	console.log "Server has started."

requestHandler = (request, response) ->
	console.log "Request received for:", request.url, "with type:", request.method
	file_path = "." + request.url
	
	if request.method is 'GET'
		getHandler file_path, response
	else if request.method is 'POST'
		postHandler file_path, request, response
	else
		console.log "Unsupported method"
		response.end()
	
	
getHandler = (file_path, response) ->
	console.log "GET received, GET Handler responding"
	router file_path, response
	
postHandler = (file_path, request, response) ->
	console.log "POST received, POST Handler responding"
	router file_path, response
	
router = (file_path, response) ->
	if file_path is './'
		serveSync "./index.html", response, "text/html" 
		return
		
	extension = path.extname file_path
	
	if extension is '.js'
		serve file_path, response, "text/javascript" 
	else if extension is '.css'
		serve file_path, response, "text/css"
	
serve = (file_path, response, content_type) ->
	path.exists file_path, (exists) ->
		if exists 
			fs.readFile file_path, (error, content) ->
				if error 
					response.writeHead(500)
					response.end()
				else 
					response.writeHead 200, 'Content-Type': content_type
					response.end content, 'utf-8'
		else 
			response.writeHead 404
			response.end() 

serveSync = (file_path, response, content_type) ->
	if path.existsSync file_path
		content = fs.readFileSync file_path
		response.writeHead 200, 'Content-Type': content_type
		response.end content, 'utf-8'
	else
		response.writeHead 404
		response.end()
start()	