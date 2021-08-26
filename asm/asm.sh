#!/bin/sh

name=`basename $0 .sh`
tag=hohsaki/asm:1.0

run_opts='-d --restart always'
while getopts 'f' var
do
    case "$var" in
	f) run_opts='-it --rm' ;;
    esac
done
shift `expr $OPTIND - 1`

case "$1" in
    start)
	docker run $run_opts \
	       --name $name \
	       --hostname $name \
	       -p 3332:22 \
	       -e TZ=Asia/Tokyo \
	       $tag
	;;
    stop)
	docker rm -f $name
	;;
    restart)
	$0 stop
	$0 start
	;;
    shell)
	docker exec -it $name /bin/bash
	;;
esac
