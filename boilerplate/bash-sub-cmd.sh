progname=$(basename $0)

sub_help() {
  printf "Usage: $progname <subcommand> [options] %c" $'\n'
  printf "Subcommands:"
  printf "    bar   Do bar"
  printf "    baz   Run baz"
  printf ""
  printf "For help with each subcommand run:"
  printf "$progname <subcommand> -h|--help"
  printf ""
}

sub_bar() {
  printf "Running 'bar' command."
}

sub_baz() {
  printf "Running 'baz' command."
  printf "First arg is '$1'."
  printf "Second arg is '$2'."
}

subcommand=$1
case $subcommand in
  "" | "-h" | "--help")
    sub_help
    ;;
  *)
    shift
    sub_"${subcommand}" "$@"
    if [ $? = 127 ]; then
      printf "Error: '$subcommand' is not a known subcommand." >&2
      printf "       Run '$progname --help' for a list of known subcommands." >&2
      exit 1
    fi
    ;;
esac
