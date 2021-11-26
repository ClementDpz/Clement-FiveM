fx_version 'cerulean'
game 'gta5'

description 'LIL-SHOPS'
version '1.0.0'

shared_scripts {
	'config.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/*.js'
}

lua54 'yes'
