fx_version 'cerulean'
game 'gta5'

author 'ShahZaM'

files { 'html/**' }
ui_page 'html/index.html'

shared_scripts { '@es_extended/imports.lua', 'config.lua' }
client_scripts { 'client/*.lua' }
server_scripts { '@mysql-async/lib/MySQL.lua', 'server/*.lua' }

dependencies {
  'es_extended',
  'xsound'
}