##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# https://www.morningstarsecurity.com/research/whatweb
##
Plugin.define do
	name "Plugin-Tutorial-7"
	authors [
		"Your preferred name <email@address>", # v0.1 # 2019-01-01 # Created plugin
		# Your preferred name # v0.2 # 2019-01-11 # Added cookie detection
		# Your preferred name # v0.3 # 2019-03-17 # Added plenty of example matches
	]
	version "0.3"
	description "Describe what the plugin identifies"
	website "http://example.com/"

	# Dorks # 
	dorks [
	'"Generic CMS login"',
	'Generic login register linkname',
	]

	# A comment block here is a good place to make notes for yourself and others


	# This is the matches array. 
	# Each match is treated independently.


	##
	# These are the symbols that can be used in matches.
	#
	## Pattern Matching ##
	# :regexp        -- A regular expression in Ruby format, eg. /^foobar$/
	# :text          -- Case insensitive text
	# :ghdb          -- Google Hack Database format. This supports the use of intitle:, inurl: and minus.
	# :md5           -- The MD5 sum hash of the HTTP response body
	# :tagpattern    -- A list of HTML tag names.
	#
	## Where to Search ##
	# :search        -- Can be "body" (default), "all", "headers", or "headers[x]" for a specific HTTP header
	#
	## Naming the plugin match ##
	# :name          -- You can optionally name the match. This name is displayed in verbose output.
	#
	## Returning Data ##
	#  Each of these symbols can be a regular expression or text.
	#
	# :version       -- The version
	# :account       -- A user account name
	# :module        -- A module name
	# :make          -- The make, e.g. NetGear
	# :model         -- The model, e.g. SpeedErr
	# :firmware      -- The firmware, e.g. 6.14.14
	# :filepath      -- A filepath. These can be displayed in error messages
	# :string        -- This is to return data that isn't covered by the symbols above. E.g. an email address.
	#
	## How certain is this pattern? ##
	# :certainty     -- how certain is this match. 100 is certain (default), 75 is probably, and 25 is maybe
	#
	## Limit the match to a URL path or an HTTP status ##
	# :url            -- you can combine this with other variables or use by itself
	# :status         -- The HTTP status of the response
	##


	# Matches #
	matches [

		# This searches for a text string. 
		{ :text => "This page was generated by <b>Generic CMS</b>" },

		# This searches for a regular expression. Note that the slashes are escaped.
		{ :regexp => /This page was generated by <a href="http:\/\/www.genericcms.com\/en\/products\/generic-cms\/">Generic CMS<\/a>/ },

		# This searches for a text string and the match has a name that appears in verbose output
		{ :name => "Meta generator",  :text => '<meta name="generator" content="(c) by Generic CMS"' },

		# The :certainty symbol is used to note matches that are not 100% certain.
		# 		:certainty => 100 is certain' (default)
		#  		:certainty => 75 is probably
		#  		:certainty => 25 is maybe
		 
		# :certainty is 25. If the title tag is matched, then maybe this webpage is the Generic CMS
		{ :name => "title", :certainty => 25, :text => "Generic Links from Generic CMS" }, 

		# :certainty is 75. This means that if the title tag is matched, then this webpage is probably the Generic CMS
		# This plugin match is split across multiple lines. This can aid readability.
		{ :name => "title", 
		  :certainty => 75, 
		  :text => "<title>Generic CMS Homepage</title>" }, 


		# check the presence of an HTTP header
		{ :search => "headers[genericxxx]", :regexp => /^.*$/ },

		# return the contents of an HTTP header
		{ :search => "headers[genericversion]", :version => /^(.*)$/ },


		# This returns the version.
		# The :version symbol is a regular expression. Whatever is found within the parenthesis is returned as the value of :version
		{ :name => "Meta Generator", :version => /<meta name="generator" content="\(c\) by Generic CMS (v[^ ]+)/ }, 

		# This returns a module.
		# The :module symbol is also a regular expression like :version. Note that the parenthesis is now after the text, "with modules"
		{ :name => "Version in Meta Generator", :version => /<meta name="generator" content="\(c\) by Generic CMS v[0-9]+ with modules ([^"]+)/ }, 

		# You don't always have the return the first result from the regular expression.
		# Note the :offset => 1. This returns the result of the second set of parentheses within the regular expression
		# The :module symbol is also a regular expression like :version. Note that the parenthesis is now after the text, "with modules"
		{ :name => "Version in Meta Generator", :version => /<meta name="generator" content="\(c\) by Generic CMS v([0-9]+) with modules ([^"]+)/, :offset => 1 }, 


		# :url can be used to limit a match to a URL path
		# This matches if both the URL path and the text is found
		# When WhatWeb is in aggressive mode, it will check if /admin/login.php exists
		{ :url => '/admin/generic-cms-login.php', :text => 'Generic CMS Login Panel' },


		# Generic CMS has a default favicon that displays the logo of the web application
		# In aggressive mdoe, the /favicon.ico path will be fetched
		# This matches if the HTTP response body, in this case the favicon.co image, has the follow MD5sum hash.
		{ :url => "/favicon.ico", :md5 => '12dead87beef7f00d90cafed82babe5' },


		# GHDB matches pages with a Google Hack Database format. 
		# Very few plugins use the :ghdb symbol.
		{ :ghdb => 'intitle:"Generic CMS" login register', :certainty => 25 },


		# This match uses :tagpattern. This is a comma delimited list of all the HTML tags in the webpage. 
		# Very few plugins use :tagpattern
		{ :url => "/generic-login.php",
		  :name => "Tag pattern for login page", 
		  :tagpattern => "!DOCTYPE,html,head,title,/title,meta,link,link,script,/script,meta,/head,body,div,h1,a,/a,/h1,form,p,label,br,input,/label,/p,p,label,br,input,/label,/p,p,label,input,/label,/p,p,input,input,input,/p,/form,p,a,/a,/p,p,a,/a,/p,/div,script,/script,/body,/html" },

	] 

end
