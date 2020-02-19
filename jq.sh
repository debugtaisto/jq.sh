__jq_stack=()
__jq_source=

function jqsource() {
  __jq_source="$@"
}

function jqpush() {
  __jq_stack+=("$@")
}

function jqpop() {
  unset '__jq_stack[${#__jq_stack[@]}-1]'
}

function jqdo() {
  query="."
  for p in ${__jq_stack[*]}; do
    query=$query" | "$p
  done
  jq -r "$query | $@" $__jq_source
}

function jqvar() {
  for var in "$@"; do
    value=$(jqdo ".$var")
    if [[ $value == "null" ]]; then
      value=
    fi
    declare -g $var=$value
  done
}

function jqarg() {
  args=
  for a in $(jqdo "to_entries|map(\"--\(.key) \(.value|tostring)\")|.[]"); do
    args=$args" "$a
  done
  declare -g $1=$args
}
