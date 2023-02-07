##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# https://www.morningstarsecurity.com/research/whatweb
##
Plugin.define do
name "Netscape-Enterprise"
authors [
  "Brendan Coles <bcoles@gmail.com>", # 2011-03-14
  "Andrew Horton", # v0.2 # 2016-04-23 # Moved patterns from passive function to matches[]. 
]
version "0.2"
description "Netscape Enterprise Server was a web server developed originally by Netscape Communications Corporation. The product has since been renamed Sun Java System Web Server, reflecting the product's acquisition by Sun Microsystems."
website "http://wikis.sun.com/display/WebServer/Sun+Java+System+Web+Server"

# ShodanHQ results as at 2011-03-14 #
# 11,641 for Netscape-Enterprise

matches [
	# HTTP Server Header
	{ :regexp=>/^Netscape-Enterprise/, :search=>"headers[server]" },
	
	# Version Detection
	{ :version=>/^Netscape-Enterprise\/(.+)$/, :search=>"headers[server]" },

]

end

