local m = require "config.utils.map"

require("substitute").setup {}

m.nmap("s", require("substitute").operator)
m.nmap("ss", require("substitute").line)
m.nmap("S", require("substitute").eol)
m.xmap("s", require("substitute").visual)

m.nmap("sx", require("substitute.exchange").operator)
m.nmap("sxx", require("substitute.exchange").line)
m.xmap("X", require("substitute.exchange").visual)
m.nmap("sxc", require("substitute.exchange").cancel)
