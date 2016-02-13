#!/bin/bash

if [[ -n "$NOM_USE_RBENV" ]]; then
  if [[ ! (-x "$(which rbenv)") ]]; then
    echo "ERROR: Failed to setup Ruby environment: rbenv command not found."
  fi

  eval "$(rbenv init -)"
  export RBENV_ROOT=${HOME}/.rbenv
else
  # IMPORTANT(jeff): This section is a stub out for future expansion; the
  # environment setup is incomplete and untested!
  echo "WARNING: Not using rbenv to setup Ruby environment; this is **not** supported!"

  if [[ ! (-x "$(which ruby)") ]]; then
    echo "ERROR: Failed to setup Ruby environment: Ruby interpretor not found."
  fi

  # Try to setup our Ruby environment based on Apple's system distribution
  RUBY_MIN_VERSION=2.0.0
  RUBY_FULL_VERSION=$(ruby -e 'puts "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"')
  RUBY_SHORT_VERSION=$(ruby -e 'puts "#{RUBY_VERSION}"')

  if [[ ${BASH_CFLAGS_DEBUG} -gt 0 ]]; then
    echo "RUBY_MIN_VERSION: ${RUBY_MIN_VERSION}"
    echo "RUBY_FULL_VERSION: ${RUBY_FULL_VERSION}"
    echo "RUBY_SHORT_VERSION: ${RUBY_SHORT_VERSION}"
  fi

  if [[ ${RUBY_SHORT_VERSION} < ${RUBY_MIN_VERSION} ]]; then
    echo "WARNING: The system distribution's Ruby interpreter does not match "
    echo "the minimum version requirement of ${RUBY_MIN_VERSION}."
  fi

  # TODO(jeff): Where is a good default gem path on a typical Linux setup?
  case "$(uname -s)" in
    Darwin)
      # NOTE(jeff): Derives from the system-wide, ruby binaries set to
      # /Library/Ruby (requires root privileges by default)
      export GEM_HOME="${HOME}/Library/Ruby/Gems/${RUBY_SHORT_VERSION}"
      export GEM_PATH="${HOME}/Library/Ruby/Gems/${RUBY_SHORT_VERSION}/gems"
      export RUBYLIB=${GEM_PATH}
    ;;
    *)
      # Catch-all
      export GEM_HOME="${HOME}/.ruby/gems/${RUBY_SHORT_VERSION}"
      export GEM_PATH="${HOME}/.ruby/gems/${RUBY_SHORT_VERSION}/gems"
      export RUBYLIB=${GEM_PATH}
      # export GEM_HOME=/usr/local/opt/Ruby/Gems
    ;;
  esac

  # Create the local site's environment binaries for the Ruby version in use
  mkdir -p "${GEM_HOME}"
  mkdir -p "${GEM_PATH}"

  # Add the local site's Ruby environment binaries
  PATH="${GEM_HOME}/bin:${PATH}"; export PATH

  # NOTE(jeff): Local Ruby site environment for development
  # RUBYOPT="-W2 -v"
  # RUBYLIB="/Library/Ruby"; export RUBYLIB
  # export RUBYLIB="/home/jeff/Projects/ruby/lib"
fi # end if a Ruby environment is requested
