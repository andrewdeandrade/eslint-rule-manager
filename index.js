/**
 * Module dependencies.
 */

var express = require('express')
  , app = express();

// configure

app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.static(__dirname + '/rules'));

app.get('/:user/:project/master/:file', function(req, res){
	var user = req.params.user;
	var project = req.params.project;
	var file = req.params.file;
	res.sendfile('registry/' + user + '-' + project +'/' + file);
});

app.post('/:user/:project/:version/:file', function(req, res){
	var user = req.params.user;
	var project = req.params.project;
	var file = req.params.file;
	res.sendfile('registry/' + user + '-' + project + '/' + file);
});

app.all('*', function(req, res){
  res.sendfile('index.html');
});

app.listen(3030);
console.log('listening on 3030');
