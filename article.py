#!/usr/bin/env python

import sys

with open('index.html', 'r') as f:
    lines = f.readlines()
    try:
        ln = lines.index('<!--INSERT ARTICLES BELOW-->\n');
    except ValueError:
        sys.exit(1)

href = raw_input("URL: ")
title = raw_input("Title: ")
auth = raw_input("Author: ")

with open('index.html', 'w') as f:
    lines.insert(ln + 1, '<li><a href="%s" target="_blank">"%s"</a> by %s</li>\n' % (href, title, auth))
    f.writelines(lines)

