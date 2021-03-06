http = require 'http'
util = require 'util'
fs = require 'fs'
path = require 'path'
qs = require 'querystring'

mongo = require 'mongodb'
Server = mongo.Server
Db = mongo.Db

server = new Server('localhost', 27017, {auto_reconnect: true});
db = new Db 'chat', server

start = ->
	http.createServer(requestHandler).listen(8888)	
	console.log "Server has started."

requestHandler = (request, response) ->
	console.log request.method, request.url
	file_path = "." + request.url
	
	if request.method is 'GET'
		getHandler file_path, response
	else if request.method is 'POST'
		postHandler file_path, request, response
	else
		console.log "Unsupported method"
		response.end()
	
	
getHandler = (file_path, response) ->
	router file_path, response
	
postHandler = (file_path, request, response) ->
	body = ''
	request.on 'data', (data) ->
		body += data
	request.on 'end', ->
		obj = JSON.parse(body)
		db.open (err, db) ->
			if not err 
				db.collection 'posts', (err, collection) ->
					collection.insert({"text": obj.text, "time": obj.time})
			db.close()
	router file_path, response
	
router = (file_path, response) ->
	if file_path is './'
		serveSync "app/views/index.html", response, "text/html" 
		return
	else if file_path is './chat'
		db.open (err, db) ->
			if not err
				db.collection 'posts', (err, collection) ->
					collection.find().toArray (err, docs) ->
						response.writeHead 200, 'Content-Type': 'text/JSON'
						for doc in docs							
							response.write JSON.stringify(doc)
						
						response.end()
						db.close()
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