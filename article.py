#!/usr/bin/env python

from datetime import datetime as dt
from sys import exit

ARTICLE_FORMAT = '<li><a href="%s" target="_blank">"%s"</a> by %s</li>\n'
UPDATED_FORMAT = 'Last updated %s.\n'

with open('index.html', 'r') as f:
    lines = f.readlines()
    try:
        art_ln = lines.index('<!--INSERT ARTICLES BELOW-->\n')
        mod_ln = lines.index('<!--LASTMOD DATE BELOW-->\n')
    except ValueError:
        print "Failed to find one or both marker lines; terminating"
        exit(1)

href = raw_input("URL: ")
title = raw_input("Title: ")
auth = raw_input("Author: ")

with open('index.html', 'w') as f:
    lines.insert(art_ln + 1, ARTICLE_FORMAT % (href, title, auth))
    lines[mod_ln + 2] = UPDATED_FORMAT % dt.now().strftime('%d %B %Y')

    arcf_ln = lines.index('<!--ARCHIVE FROM ABOVE-->\n')
    arct_ln = lines.index('<!--ARCHIVE TO BELOW-->\n')
    to_archive = lines[arcf_ln - 1]
    del lines[arcf_ln - 1]
    lines.insert(arct_ln, to_archive)

    f.writelines(lines)
