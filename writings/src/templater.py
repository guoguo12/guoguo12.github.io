#!/usr/bin/env python

# Basic HTML templating engine (AKA reinventing the wheel)
# To be run from one directory above

import sys

FIELDS = ['title', 'date', 'length']
FILE = 'src/template-header.html'

if len(sys.argv) != len(FIELDS) + 2:
    print "Usage: python src/templater.py [discarded] " + ' '.join('[%s]' % f for f in FIELDS)
    sys.exit(1)

with open(FILE) as f:
    text = f.read()
    for i, field in enumerate(FIELDS):
        value = sys.argv[i + 2]
        text = text.replace('{{%s}}' % field, value)
    print text
