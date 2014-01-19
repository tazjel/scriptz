#!/bin/bash

# Alternative version in perl
#urlencode() {
#    echo -n "$@" | \
#            perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'
#    echo
#}


urlencode(){    
  python -c "import sys, urllib as ul; s=u'$1'; print ul.quote_plus(s.encode('utf8'))" ;   
}

urlencode "$@"
