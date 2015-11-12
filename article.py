#!/usr/bin/env python

import datetime, sys

with open('index.html', 'r') as f:
    lines = f.readlines()
    try:
        art_ln = lines.index('<!--INSERT ARTICLES BELOW-->\n')
        mod_ln = lines.index('<!--LASTMOD DATE BELOW-->\n')
    except ValueError: 
        print "Failed to find line; terminating"
        sys.exit(1)

href = raw_input("URL: ")
title = raw_input("Title: ")
auth = raw_input("Author: ")

with open('index.html', 'w') as f:
    lines.insert(art_ln + 1, '<li><a href="%s" target="_blank">"%s"</a> by %s</li>\n' % (href, title, auth))
    lines[mod_ln + 2] = 'Last updated %s.\n' % datetime.datetime.now().strftime('%d %B %Y')
    
    arcf_ln = lines.index('<!--ARCHIVE FROM ABOVE-->\n')
    arct_ln = lines.index('<!--ARCHIVE TO BELOW-->\n')
    to_archive = lines[arcf_ln - 1]
    del lines[arcf_ln - 1]
    lines.insert(arct_ln, to_archive)

    f.writelines(lines)

