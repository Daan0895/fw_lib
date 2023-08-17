fx_version "cerulean"
game "gta5"
lua54 "yes"

author "daan0895"
description "fw lib"
version "1.0.0"

shared_scripts {
    'shared/**',
    "imports.lua"
}

client_scripts {
    "client/**"
}

server_scripts {
    "server/**",
    '@mysql-async/lib/MySQL.lua'
}

files {
    'html/index.html',
    'html/index.js',
    'html/style.css',
}

ui_page 'html/index.html'
