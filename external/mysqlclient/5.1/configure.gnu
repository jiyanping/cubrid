#!/bin/sh

srcdir=''
BIT_TYPE=32

while test $# -ge 1; do
  case "$1" in
    -h | --help)
      echo 'configure script for external package'
      exit 0
      ;;
    --srcdir=*)
      srcdiropt=`echo $1 | sed 's/--srcdir=//'`
      srcdir=`readlink -f $srcdiropt`
      shift
      ;;
    --enable-64bit)
      BIT_TYPE=64
      shift
      ;;
    *)
      shift
      ;;
  esac
done

case $SYSTEM_TYPE in
  *linux*) 
    ;;
  *)
    BIT_TYPE=0
    ;;
esac

if [ $BIT_TYPE -ne 64 ]
then
	echo "CAS for MySQL builtin library support 64bit linux only."
	exit 1
fi

CHECK_FILE=../../mysqlclient/5.1/lib/libmysqlclient.so
if [ -e $CHECK_FILE ]; then
	echo "built already. skip $PWD"
else
  mkdir -p ../../mysqlclient/5.1
  ln -s $srcdir/include ../../mysqlclient/5.1/include
  mkdir -p ../../mysqlclient/5.1/lib
  ln -s $srcdir/lib64/libmysqlclient.so.16.0.0 ../../mysqlclient/5.1/lib/libmysqlclient.so
fi