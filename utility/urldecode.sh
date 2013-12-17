#!/bin/bash
urldecode(){
  python -c "import sys, urllib as ul; print ul.unquote_plus('$1')" ;
}

urldecode "$@"
