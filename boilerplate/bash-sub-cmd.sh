progname=$(basename $0)

sub_help() {
  echo "Usage: $progname <subcommand> [options]\n"
  echo "Subcommands:"
  echo "    bar   Do bar"
  echo "    baz   Run baz"
  echo ""
  echo "For help with each subcommand run:"
  echo "$progname <subcommand> -h|--help"
  echo ""
}

sub_bar() {
  echo "Running 'bar' command."
}

sub_baz() {
  echo "Running 'baz' command."
  echo "First arg is '$1'."
  echo "Second arg is '$2'."
}

subcommand=$1
case $subcommand in
  "" | "-h" | "--help")
    sub_help
    ;;
  *)
    shift
    sub_${subcommand} $@
    if [ $? = 127 ]; then
      echo "Error: '$subcommand' is not a known subcommand." >&2
      echo "       Run '$progname --help' for a list of known subcommands." >&2
      exit 1
    fi
    ;;
esac
