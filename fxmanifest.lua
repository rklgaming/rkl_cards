fx_version 'cerulean'
game 'gta5'

description 'Collectibles Cards'
version '1.0'
ui_page "html/index.html"

files {
    'html/index.html',
    'html/js/*.js',
    'html/css/*.css',
    'html/img/*.png',
    'html/img/*.jpg'
}
client_scripts {
	'client/client.lua',
	'config.lua'
}
server_scripts {
	'server/server.lua',
	'config.lua'
}


