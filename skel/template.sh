#!/bin/bash -

# vim: filetype=sh

####################################################################
# Changelog:
#
# Todo:
#   *) Change default values
#
# Notes: 
#   As the PATH is set to a saner (reduced) value, some filters
#   and tools might not be located as expected; if this is the case,
#   prefer naming the tool with full path e.g. '/usr/bin/tar' rather
#   than 'tar'.
####################################################################

# Set IFS explicitly to space-tab-newline to avoid tampering
IFS=' 	
'

# If found, use getconf to constructing a reasonable PATH, otherwise
# we set it manually.
if [[ -x /usr/bin/getconf ]]
then
  PATH=$(/usr/bin/getconf PATH)
else
  PATH=/bin:/usr/bin:/usr/local/bin
fi



function usage()
{
  cat <<Usage_Heredoc
Usage: $(basename $0) [OPTIONS]

This is a simple script that analyzes module verification reports copied
by the mvrpt_copier script, and generates a basic trend

Where valid OPTIONS are:
  -h, --help  display usage

Usage_Heredoc
}

function error()
{
  echo "Error: $@" >&2
  exit 1
}

function parse_options()
{
  while (($#))
  do
    case $1 in
      -h|--help)
        usage
        exit 0
        ;;
      *)
        usage
        error "Unknown option: $1"
        ;;
    esac

    shift
  done
}


parse_options "$@"

